Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A043D37AD4A
	for <lists+linux-can@lfdr.de>; Tue, 11 May 2021 19:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEKRpY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 May 2021 13:45:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:11715 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEKRpX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 May 2021 13:45:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620755054; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=skmYe45i9hZr5ScmEnkga6owMtgAI5IDsLrHdd5vKut0PYiCW2KqaPvYYKoM/uimLs
    C1BymL77BnEo9x00i2XEBoQjE0MJuGHlK2yeik81Z4VoE6hEaOtfJhNalcT+qwpq5dEq
    Zue1XBTZlsvpCtNioyYcYctJm8Gr8nC5RFuGqnypgRwo7VU5l1dj9V4CJDzatPZlAfs7
    ySn92GK5klEsHmunV7f8NpLHQnCTMBkEG3Irx6mGTAAv6wjWn0d6/1mQnWN0RK2tINpD
    cNQkDH0/TWSi1r+4eF9XgPa+Vs7rUzH3bf5a/s4/BEffRrgA79ZYM/FoMWTICtudMiM+
    ZROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620755054;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=W92xU5GWr+hJ3VyvfRpKET1qrDrsd2ZJ0F835qQcDNM=;
    b=L1b8j9QukhOmMxINXcRJ6TqMGModlGP/+mQuFlruIGJaXJ9gsJ7YZqAGL5vZKXPtwk
    lwZUglZr1O0P0cdKeGyus4Jw/DGEKQ7b/UfnXDCrCt88u0ayIlHFFEzjtSA9RIs38aYT
    jIxjEsSmJDfyTvEJSKxvJP63NvrEJ5OygrSyg+p81alUqN9zXYxe3quo33MklK03++Rm
    cBrRCreejSja3XXisOpzar92/akGFj1Q/jXB8i1YcGsMnA89BX4L8oMJbZRiLAwVxe+r
    y2drGAHuuyygBqBAJKbcFfjYHwFwDtAO07M2ObyBM/54IOHuVCPxh9u6P0Se/m39wwJ9
    f6XQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620755054;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=W92xU5GWr+hJ3VyvfRpKET1qrDrsd2ZJ0F835qQcDNM=;
    b=ChmW6064J8OqbUliRo7XGVBwYnzOTN8PdE3e9Yl0nso0HstmbttkmgaisFJdDRTrNB
    jILl7Ran1aHzY68CNOFpGcTbaLgZYFFHvhpuE5oQd3xBsmaPvifPGLqbhgbDGp3L7G4f
    hxEnDHQD42tkERSlLJFntNnHNL+4x4malGoDaFljj5ry612Bd5MV9xCmwbP53zHZLmy8
    U0El9ttCYVzCu5CheaSMl6IiCsv9gk3MWBnr0do7ehDSPKlA9xydZzJex4K7mvtHsz2w
    EdmIk+Vycmsy1h61i2j3TfsWes8/iWkE2t50/MiDmGD5U0vegPIOr21LE6HTlqq5Cwld
    /EqA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKN9eTTrsO"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.25.7 DYNA|AUTH)
    with ESMTPSA id I04856x4BHiE0g6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 19:44:14 +0200 (CEST)
Subject: Re: CAN ISO-TP
To:     Patrick Menschel <menschel.p@posteo.de>,
        Bartosz Zdanowicz <zdanowiczb@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
 <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net>
 <CAERdor5o6yKq1J-hBbjiBtU63OkxhijKifO0OEBt21ASKhCXuw@mail.gmail.com>
 <02607798-4701-376a-6a58-2ff29c87ccab@posteo.de>
 <CAERdor7LiPPJWLxMQdrQsF=jU0yHNU_uwLAbQegpUj4KeJHzgg@mail.gmail.com>
 <587ef081-804b-9816-f899-f4bd645865cf@posteo.de>
 <CAERdor4VkyxQ3X4gZn1jR9PFkwg2BqbC+iG9DQXECakdpsotkA@mail.gmail.com>
 <7ad89748-c309-1153-aa8f-b0e98160e39d@posteo.de>
 <43d77f58-1ec9-302c-d8f0-654444046cab@posteo.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <90c29725-5d6d-e4b9-6e28-a002a8f0bfcf@hartkopp.net>
Date:   Tue, 11 May 2021 19:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <43d77f58-1ec9-302c-d8f0-654444046cab@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 11.05.21 18:37, Patrick Menschel wrote:
> Am 10.05.21 um 20:04 schrieb Patrick Menschel:
>> Am 10.05.21 um 12:02 schrieb Bartosz Zdanowicz:
>>> pt., 7 maj 2021 o 09:59 Patrick Menschel <menschel.p@posteo.de> napisał(a):
>>>> try to enable CAN_ISOTP_WAIT_TX_DONE via socket.setsockopt() .
>>>> https://github.com/raspberrypi/linux/blob/rpi-5.10.y/net/can/isotp.c#L14
>>>>
>>>> https://gitlab.com/Menschel/socketcan/-/blob/master/socketcan/socketcan.py#L583
>>>>
>>>> and wrap tx into a try-except block.
>>>>
>>>> try:
>>>>      self.process_data(socket=socket)
>>>> except OSError as e:
>>>>      print(e)
>>>>
>>>> With this you actually have a chance to do error handling on tx path
>>>> instead of hitting an already present error of the previous op.
>>>>
>>> I used following code:
>>>
>>> import isotp
>>> import time
>>> s = isotp.socket()
>>> s._socket.settimeout(2)
>>> s.set_opts(s.flags.WAIT_TX_DONE)
>>> s.bind("can0", isotp.Address(rxid=1, txid=2))
>>>
>>> s.send(b"aaaaaaaaa") -> returns immediately with number of bytes
>>> s.send(b"aaaaaaaaa") -> same OS error as above (Error 70)
>>>
>>
>> OK,
>>
>> this is really strange. I have no clue how that is possible unless it's
>> on kernel side.
>>
>> I have to write a test for it later.
> 
> I can confirm this behaviour, it is definetly kernel-side of the socket.
> 
> tests/test_socketcan.py::TestCanIsoTpSocket::test_should_fail_missing_flow_control_on_transfer
> 
> --------------------------------------------------------------------------------------------------
> live log call
> --------------------------------------------------------------------------------------------------
> 2021-05-11 18:14:00 [    INFO] Return value of IsoTpSend without flow
> control: 64 (test_socketcan.py:720)
> 2021-05-11 18:14:01 [   ERROR] Return value of IsoTpSend without flow
> control: None, Raised [Errno 70] Communication error on send
> (test_socketcan.py:718)
> 
> Apparently there is another message thread for this and something was fixed.
> 
> https://marc.info/?i=97e2ddd5-cc8b-9c7b-6198-2eceee39dfd4%20()%20hartkopp%20!%20net
> 
> Funny thing is, it does not care about the wait_tx_done flag, this
> happens with and without it.

The error handling was originally intended to be done by simple timeout 
monitoring on application level.

What I assume from the output above:

1st attempt: We have a failure but we happily return that we have send 
64 bytes (which Marc improved with the above referenced patch for 
CAN_ISOTP_WAIT_TX_DONE mode).

(socket remains open?!?)

2nd attempt: The error from the first attempt shows up in the socket 
error message queue?!?

I just did some tests with a modified isotpsend.c which closes the 
socket after the sending operation. This is probably the reason I did 
not see that behaviour ...

Regards,
Oliver
