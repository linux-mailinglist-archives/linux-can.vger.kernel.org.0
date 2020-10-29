Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811D29F6ED
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 22:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgJ2VdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Oct 2020 17:33:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:27714 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ2VdT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2020 17:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604007196;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=QRFPJ05CiBVpVECE0FaCPp52O0nfrVDpKYBi8/q5d40=;
        b=DzIPLCsptU8jZCDyXfIY5AWdY7eLvy3fN9ZKDigtMMCAqKOIw0yyGqAlILNnajSf8L
        mKzEeziSh9KiV+liw2do5MzYXvMztEkEMi3VfzMbpKPw+KYbhq6/kChwR9Jaxm5Mjbkr
        dzgg1WJEqYMciInh68u8s4uttAf2ov693G9AvJkNvjqDBbH+wEJEQEJegTr8ZQYQCsVb
        oHqkSyrTyECirHBf0eRKFTSCPCzo/QoLKhL/aF9IFCXy/dW2P215b+3cpdOUcHbEOZVS
        URp+xWtIQCqCvADcyg68zEIy2AX8KrAnBmAUhtURpg105BEPPNgvFRF/4H4rsZyUePZu
        vfkw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKONeaTdI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bew9TLXE2zc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 29 Oct 2020 22:33:14 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <CAMZ6RqKQjD5vWeya1CEpNuaZb=vUYWtkgL1rDr1fcBvBRDdgxA@mail.gmail.com>
 <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
Message-ID: <6bfdc3db-5aaf-b492-dc24-fb5d73cd3b23@hartkopp.net>
Date:   Thu, 29 Oct 2020 22:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e23e5ebd-5bd9-dca2-5c1e-9adbd009cf99@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 24.10.20 15:00, Oliver Hartkopp wrote:
> On 24.10.20 14:00, Vincent MAILHOL wrote:

>>    * Set up two channels can0 and can1 and connected those to the same
>>      bus.
>>
>>    * Ran 'cangen can0' and 'candump any' simultaneously.
>>
>>
>> Results of candump:
>>    can0  539   [8]  05 21 8C 5C F7 B0 7C 69
>>    can1  539   [8]  05 21 8C 5C F7 B0 7C 69
>>    can0  47E   [1]  53
>>    can1  47E   [1]  53
>>    can0  317   [6]  E5 00 B5 73 66 CF
>>    can1  317   [6]  E5 00 B5 73 66 CF
>>    can0  524   [E]  64 C3 B0 6E 55 7A D7 2E
>>    can1  524   [E]  64 C3 B0 6E 55 7A D7 2E
>>    can0  39C   [D]  63 18 96 69 F6 7A AB 36
>>    can1  39C   [D]  63 18 96 69 F6 7A AB 36
>>    can0  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>    can1  60D   [F]  F2 C6 B6 1D 80 FB BC 7E
>>    can0  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>    can1  5DD   [9]  7E 55 56 5B C0 23 B0 53
>>    can0  573   [E]  20 8E A3 31 1B 54 B2 16
>>    can1  573   [E]  20 8E A3 31 1B 54 B2 16
>>    can0  470   [3]  31 9C 06
>>    can1  470   [3]  31 9C 06
>>    can0  465   [4]  93 75 A2 08
>>    can1  465   [4]  93 75 A2 08
>>
>>
>> Works fine :-)

I'm not really sure about the view of Classical CAN DLCs in this 'long' 
candump representation.

There are people that use this format as base for further processing - 
instead of the logfile format m(
So it may be a bad decision to put the DLC value in the length position 
here.

I changed the logfile format in a backward compatible way and therefore 
the cansend command line format too:

(1604004658.444168) vcan0 2C0##02643
(1604004658.494492) vcan0 615#R8_9
(1604004658.645395) vcan0 6FF#
(1604004658.695682) vcan0 623##318F88F7043C0
(1604004658.746046) vcan0 63A##28D1F37
(1604004658.796214) vcan0 1117DEA5##0BC281D711098
(1604004658.846397) vcan0 1490B893#R8_F
(1604004658.896585) vcan0 1F494EC8##39C47E2
(1604004658.947142) vcan0 1D1EC448#3DC1C81345D7ED7E_D
(1604004658.997689) vcan0 1C8661BB##14DEA7568D459160D
(1604004659.047851) vcan0 2D8#AFE0546E6522130D_E
(1604004659.098216) vcan0 1596E833##3E6789514EF10B466E6789514EF10B466

My can-utils len8_dlc test setup is here:
https://github.com/hartkopp/can-utils

Feel free to do some tests, e.g. with cangen, candump, canplayer. 
Feedback is appreciated.

Best,
Oliver

