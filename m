Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0247A48365E
	for <lists+linux-can@lfdr.de>; Mon,  3 Jan 2022 18:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiACRnx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 Jan 2022 12:43:53 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:19113 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiACRnw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Jan 2022 12:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641231647;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=KKwxdhJOfu6SZYAp/lX7bRKFwGE5TLSfHYc9aed5P7I=;
    b=C28zAoTdw/OqGTIqGhUNExW9xYFaYpZU9zDOCN7Io1dEr4QD+lyiHZ+jHnDz8e9XAA
    XKsM0xFUGzT1NpPcJXoIBcn+5xXhz9PiS2N/vvhR5eMuaVrrqeba5F72VktJVpafT0jm
    KE6pw55lWD+danNWBu++dxz2ZcvbEf4RikZDOaXCCaCF9IEUROv9P1BW8S0IDMAis+8m
    J8lNplyof0B/ycaKwzLIU7sjGiHA8mf9IFwdkR3ORfZF3td+mCF7uM+3j3uVRzCWL+nn
    7NaOZcwzFoAdW6keupfpIP39kgFjYqaZDvN/30CN3HHcMWZk6DoyiGpL3OeO/poPv7UW
    ZvwA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.35.3 AUTH)
    with ESMTPSA id k081c3y03HelszZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 3 Jan 2022 18:40:47 +0100 (CET)
Subject: Re: can-isotp: TX stmin violations
To:     =?UTF-8?Q?Maik_Allg=c3=b6wer?= <maik@llgoewer.de>,
        linux-can@vger.kernel.org
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
Date:   Mon, 3 Jan 2022 18:40:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103155254.3htprmrdjur3ke3l@ganymed>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Maik,

On 03.01.22 16:52, Maik Allgöwer wrote:

> Imagine the receiver requests a min tx separation time of 2 ms in a
> control frame.
> 
> I then sometimes get consecutive frames with the following scheme
> of timestamps on an externally connected logger
> 
> ..
> 
> 0.0 ms : CF#1
> 2.5 ms : CF#2
> 4.0 ms : CF#3
> 
> ..
> 
> 
> In this example CF#2 is delayed by .5 ms on the wire while CF#3 is sent .5 ms too early
> when I look at the delta between CF#2 and CF#3 .
> 
> To me it seems that, while the messages are put into some tx-queue at the
> correct time, they are not actually put on the wire at that exact time leading to CF#3
> being put on the wire too early.

Yes. The CAN frames are sent with a 'minimum' gap which is defined with 
STmin, see isotp_tx_timer_handler().

Generally the handling and the sending of the frame is processed - and 
*then* the offset gap of the current time is added. In your case it 
should always be *slightly more* than 2ms, which is fine from the STmin 
specification intention.

The 0.5ms delay of CF#2 is likely introduced on CAN driver level or CAN 
bus level (arbitration?!).

With a virtual CAN it looks like this:

In terminal 1 (STmin = 2ms)

$ isotprecv vcan0 -s 123 -d 321 -m 2

In terminal 2

$ isotpsend vcan0 -d 123 -s 321 -D 30

In terminal 3

$ candump vcan0 -td
  (000.000000)  vcan0  321   [8]  10 1E 01 02 03 04 05 06
  (000.000030)  vcan0  123   [3]  30 00 02
  (000.002116)  vcan0  321   [8]  21 07 08 09 0A 0B 0C 0D
  (000.002238)  vcan0  321   [8]  22 0E 0F 10 11 12 13 14
  (000.002232)  vcan0  321   [8]  23 15 16 17 18 19 1A 1B
  (000.002080)  vcan0  321   [4]  24 1C 1D 1E

Which fits exactly the expectations.

Best regards,
Oliver
