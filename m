Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9227B23
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfEWKyq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 06:54:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35679 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbfEWKyo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 06:54:44 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1hTlMu-0002Yj-PX; Thu, 23 May 2019 12:54:40 +0200
Subject: Re: [PATCH v1 00/17] introduce socket session queue support
To:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
 <20190523102025.GC2318@x1.vandijck-laurijssen.be>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <4e068cc6-76ae-d961-ea23-b0d7b32868bc@pengutronix.de>
Date:   Thu, 23 May 2019 12:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102025.GC2318@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23.05.19 12:20, Kurt Van Dijck wrote:
> On do, 23 mei 2019 11:41:22 +0200, Oleksij Rempel wrote:
>> This patch series is a preparation and actual session queue support.
>>  From now, we are able to use full available wmem of the socket and
>> queue all requests if it is needed. The stack will process
>> all queued requests in the FIFO order and notify user space application
>> about error or completion over the errqueue interface.
> 
> I don't understand why it is necessary to queue single messages into a
> FIFO and notify user space later on?

I'm not sure I understand this question. What type of message is "single messages" in your 
case?
1. Notification in user space are optional and should be enabled by application - there 
are no necessity in it.
2. If we need to keep order of queued messages there is no way you can predict if user 
space will put one or 100 messages in it, so every message go through the FIFO.
3. The feedback mechanism is provided for every type of message since it is possible to 
drop complete queue, so we are still able to notify user space about doped or send messages.

> Are you sure that different sockets still send asynchronous from each
> other as long as TP/ETP is not involved?

Yes. It is per socket queue. First message in the queue are currently activated
independent of each other.
As soon as different sockets have same address and trying to start or queue a transfer
with conflicting type, address and direction, current stack implementation will 
block/prevent second transfer to start.

The next step would be to implement dequeuing mechanism for conflicting transfers queued 
in different sockets.

> 
> 
>>
>> As usual, reviews and tests are welcome.
>>
>> Oleksij Rempel (17):
>>    j1939: store session type in to session and start to use it
>>    j1939: transport: do not send packets from j1939_tp_send
>>    j1939: transport: seed retry timeout for (E)TP sessions
>>    j1939: pack simple messages in to a session
>>    j1939: socket: use min_t where possible
>>    j1939: transport: fix broken refcounting on j1939_xtp_rx_rts_current
>>      error
>>    j1939: move struct j1939_sock to the header file
>>    j1939: transport: return proper error on skb underrun.
>>    j1939: split j1939_tp_send
>>    j1939: transport: cancel session on j1939_tp_txnext error
>>    j1939: transport: abort not started session if requested
>>    j1939: add session state
>>    j1939: transport: better protect j1939_session_insert with lock
>>    j1939: implement session queue
>>    j1939: rename j1939_sk_send_multi to j1939_sk_send_loop
>>    j1939: rename tp_sessionq to active_session_list
>>    j1939: rename jsk_fifo to sk_session_queue_entry
>>
>>   net/can/j1939/j1939-priv.h |  78 +++++++-
>>   net/can/j1939/main.c       |   2 +
>>   net/can/j1939/socket.c     | 238 +++++++++++++----------
>>   net/can/j1939/transport.c  | 384 ++++++++++++++++++-------------------
>>   4 files changed, 388 insertions(+), 314 deletions(-)
>>
>> -- 
>> 2.20.1
>>
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
