Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4C5272C
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2019 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfFYIy6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jun 2019 04:54:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40473 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfFYIy6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2019 04:54:58 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1hfhE8-0006dx-Gw; Tue, 25 Jun 2019 10:54:56 +0200
Subject: Re: j1939: discussion: RX path
To:     David Jander <david@protonic.nl>
Cc:     dev.kurt@vandijck-laurijssen.be, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
References: <20190625073009.GA15948@pengutronix.de>
 <20190625104315.57172f69@erd988>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
Date:   Tue, 25 Jun 2019 10:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625104315.57172f69@erd988>
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



On 25.06.19 10:43, David Jander wrote:
> On Tue, 25 Jun 2019 09:30:09 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
>> Hello all,
>>
>> We already had a discussion about the J1939 use case for server
>> implementation. Short description of the challenge will looks as follow:
>> - main socket is listening on DST address and PGN.
>> - as soon as connection was requested from peer the server will
>>    create new connect()ed socket with SRC, DST addresses and PGN.
>>
>> With current stack implementation both sockets (main and connected) will
>> receive same packages. At least with huge packages it will start to be
>> not really good :).
>>
>> To solve this issue we have following variants:
>> variant a:
>>   - all sockets can receive everything (as currently implemented)
>> variant b:
>>   - only one socket will receive specific tuple. In this case kernel
>>     should calculate RX "priority". Only highest priority will RX packet.
>>     - all sockets with same priority will receive the matching packet
>>     - socket option promisc == same priority as exact match
> 
> How is this "priority" determined?
> Something like this:
> 
>   for each socket:
> 	 prio = 0
> 	 listening on same DST or PGN ==> prio++
> 	 listening on same DST and PGN ==> prio++
> 	 connect()ed to same SRC ==> prio++
>   deliver frame to socket(s) with highest prio.
> 
> Is that what you mean?

ACK.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
