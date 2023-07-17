Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A3755C7E
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGQHMr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjGQHMp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 03:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7610DA;
        Mon, 17 Jul 2023 00:12:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C1960F7A;
        Mon, 17 Jul 2023 07:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA4C433C8;
        Mon, 17 Jul 2023 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689577962;
        bh=Tx/77+tErUVZAWuLrax7VIUu2uzMqwMf9CKDUK2pqEU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N8Zd171RBHYUsQaHAzpkU5YalNpirRqrgQrWhGk7q7GZ3A+xmv7yhqJ7u3U0fKAIH
         X1jwKtSdXooNZjeRzUaMyY6jUCNCsC0AG4Xv2srM0fsZ+kK7y+lyjAFrzm+zaRL58H
         pxQ2N6y3EnC0ENoybc2oEQ+FFyfFKI92xKTOKH9agFtQoGmXPijD25dPCTdnEkrbl5
         ZiX1OkzbIG/bW15ABvmV9VnnFk95dRzqQ7uFPeifWxoJjOQLq0jArU0XmE2m+8eVgV
         pQrDjeeu6q5X18vt7t20qpVxzPtJ4Uaw+OIM5ddy524jBazcUdhnPejktX/fHFB9Hb
         LiJo1/XEqM0QQ==
Message-ID: <07aa464d-c9d8-4fe0-2063-98562a3480d6@kernel.org>
Date:   Mon, 17 Jul 2023 09:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] can: sun4i_can: Add send support for the Allwinner D1
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     John Watts <contact@jookia.org>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-4-contact@jookia.org>
 <f3b1240a-4be0-4c02-0a63-561499ad6d0d@kernel.org> <ZLQgQAigmhk9uYYd@titan>
 <eb2d6e5a-595f-85f2-fe36-8acbb76d3987@kernel.org>
 <20230717-aluminum-driven-a008473620ca-mkl@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230717-aluminum-driven-a008473620ca-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 17/07/2023 09:03, Marc Kleine-Budde wrote:
> On 17.07.2023 08:41:07, Krzysztof Kozlowski wrote:
>> On 16/07/2023 18:52, John Watts wrote:
>>> Hello,
>>>
>>> On Sun, Jul 16, 2023 at 06:36:03PM +0200, Krzysztof Kozlowski wrote:
>>>>> +static const struct sun4ican_quirks sun4ican_quirks_d1 = {
>>>>> +	.has_reset = true,
>>>>> +};
>>>>
>>>> Isn't this the same as previous?
>>>
>>> Yes, but I wanted to split up the new quirk in to its own patch.
>>
>> I don't understand why you need this new, duplicated entry. Aren't
>> devices compatible?
> 
> According to patch 4/4 the devices are not compatible.

Ah, ok, I didn't go so far because it is not obvious to add support for
a device in patch 3 which is already not correct and needs fix/followup
in patch 4.

Thanks.
> 

Best regards,
Krzysztof

