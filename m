Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39D69020B
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHPMzX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 08:55:23 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:34541 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfHPMzX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 08:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1565960121;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=p58O2hqnhc8UNAfzUShJ8SjOf3o7BpUYWi/9Vy+Vopc=;
        b=bZrXEVjNIpIuxut9stqx84eoUespXXQgu+PCd9+ZU0uHqKM/8YyUlUjd2waYYxgoWl
        qoW8D8WAiayCRhwOepbpMkerA8AWZ1iifRR0tbqLM8cQ1OdP5u7f4NeCIy8OO/YKsdUF
        1Y1hd4bLksDJxRxddsO9J5btZvzWrJyFtqr6x3CrGpBfgXI9RfljSxyDhRtvnDzjUSrB
        YuzDlUa/TXdyPbLuKjHjR6qFTO1KCMKOeQH0kIEr/KUb5ZNmnwzO+KAs50gllQ6MA3yp
        NUGZ1cX0Py4jhdmTZqeIeb4Q6qiZJHr+Hi+cXpYGVCrKRkLFxfhwkGOiDOw1/8F0Bqlk
        BLxA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch8lCA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.26.1 DYNA|AUTH)
        with ESMTPSA id R073b7v7GCtH8qH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 16 Aug 2019 14:55:17 +0200 (CEST)
Subject: Re: User-Space Can dongles? Stlink-v3Bridge as CAN dongle
To:     bon@elektron.ikp.physik.tu-darmstadt.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <23894.35590.153840.921485@gargle.gargle.HOWL>
 <a3ab86b1-12da-9ca3-899d-8385e6a332dc@pengutronix.de>
 <23894.41935.398091.806166@gargle.gargle.HOWL>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <9550d765-799d-027c-fee7-7a02ad22db0e@hartkopp.net>
Date:   Fri, 16 Aug 2019 14:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <23894.41935.398091.806166@gargle.gargle.HOWL>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Uwe,

long time no read ;-)

On 16/08/2019 14.38, bon@elektron.ikp.physik.tu-darmstadt.de wrote:
> Marc Kleine-Budde writes:
>> On 8/16/19 12:52 PM, bon@elektron.ikp.physik.tu-darmstadt.de wrote:

>>> However this would imply a user-space socketcan adapter. Is such a
>>> thing possible?
>>
>> Create a vcan and attach your userspace components to it.
>>

ACK.

> Is there some example code doing something similar?
There were some binary CAN tools that needed a serial line with SLCAN 
protocol to work.

For that reason I built this piece of code to emulate a serial line with 
a pty and connected the frame flow to a CAN socket.

https://github.com/linux-can/can-utils/blob/master/slcanpty.c

Best,
Oliver
