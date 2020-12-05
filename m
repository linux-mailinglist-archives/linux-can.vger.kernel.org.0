Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7D2CFF15
	for <lists+linux-can@lfdr.de>; Sat,  5 Dec 2020 22:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgLEVJz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 5 Dec 2020 16:09:55 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:34231 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEVJy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 5 Dec 2020 16:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607202360;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yyLJS0cTLJL5jVvZTqB5XKri3GF9RTNiqJ4VKSG2so4=;
        b=H4NMwfiXkuUaIuuxJe6FEh+w9IEaS22d5h+pWe+yY0LnUfGye4EJOU+CtWoO0mOF7k
        xdL56I3HOQUu4ZplxT2N0O0B4H1bor5XnpZX7o0FTZ2Fn1acEwZSnrblsbcSigWz1CMI
        EAOcf9NwvAoc31gyG3uyARtG1CiJl6iFrsBrPUuwm2QC4FlMD/6p0JV9Unmfryq1fiBH
        eU+SejVUZsMoC1R+VT6DbiBdAxnt6EGL3t1FxPwH8b2k9VmOcYF1CR8KKnWOyv/lfWn9
        zfT0mLn2GScRf4q/eRII1s8LBRYlsb7nsGlfryfCL2FO+aNZMMhsnpwq8vW+4cAlcT0Z
        1iJg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch5kErC"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB5L5wMBG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 5 Dec 2020 22:05:58 +0100 (CET)
Subject: Re: [PATCH] isotp: do not validate RX address when the broadcast flag
 is active
To:     Marc Kleine-Budde <mkl@pengutronix.de>, Thomseeen <thwa1@web.de>,
        linux-can@vger.kernel.org
References: <20201204135557.55599-1-thwa1@web.de>
 <df231f75-c163-14b3-7ecf-c7341608abec@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <cfe332f3-b0c6-1d49-7bf4-9525e9e10ef3@hartkopp.net>
Date:   Sat, 5 Dec 2020 22:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <df231f75-c163-14b3-7ecf-c7341608abec@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05.12.20 21:59, Marc Kleine-Budde wrote:
> On 12/4/20 2:55 PM, Thomseeen wrote:
>> EADDRNOTAVAIL shouldn't be thrown when an invalid RX address (e.g. NO_CAN_ID)
>> is set while the socket is used with the CAN_ISOTP_SF_BROADCAST flag.
>>
>> Signed-off-by: Thomseeen <thwa1@web.de>
> 
> Is this your realname? For the kernel the s-o-b requires your realname. For
> details about the S-o-b, see:
> 
> https://elixir.bootlin.com/linux/v5.9.12/source/Documentation/process/submitting-patches.rst#L423
> 

Thomas' name is correct in my patch here:
https://lore.kernel.org/linux-can/ce547683-925d-6971-6566-a0b54146090a@pengutronix.de/T/#m3c780406ff756cd0b66f1d34744fb4d8eb4abaf6

Regards,
Oliver
