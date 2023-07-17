Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF80755BE8
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGQGlQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 02:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGQGlQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 02:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7293;
        Sun, 16 Jul 2023 23:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E125F60F53;
        Mon, 17 Jul 2023 06:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4C1C433C8;
        Mon, 17 Jul 2023 06:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689576074;
        bh=ToV/RNHkRpt5CR37YhL46DLIkicgD+NHudoNcjFMJwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bw8jRnspDqFn0RQ7AUREoDjcg7eqLyV/S6Y6BxnOzOv5KT3xBWbZR3kdNhol6L5o6
         UgDIRcl20gTRSVszHMK9DkzEqWEIMyMQ7FBRI87CuySywWucjnOmQCu3VkoRNt5VI4
         57sMPEQ7HH7BcNWvUtcCOb0o79zgeTLFjFImK5axv0vQBTQWd+4KJWbKNyQXyWpf3P
         mwQ9fu8DRLkpBFQXvvjCDFhk4L2m2syxPfw6tdplMfLh6AO7+GYABm9cwEbWHcig3a
         bvGaijc2FoHZmjYAYQnapSDKpYcRPAkyxsPDbX50WsT2m6w1FYT4WUUuGhgVJXeCRz
         cp2Zhhi8A3X3g==
Message-ID: <eb2d6e5a-595f-85f2-fe36-8acbb76d3987@kernel.org>
Date:   Mon, 17 Jul 2023 08:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] can: sun4i_can: Add send support for the Allwinner D1
Content-Language: en-US
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-4-contact@jookia.org>
 <f3b1240a-4be0-4c02-0a63-561499ad6d0d@kernel.org> <ZLQgQAigmhk9uYYd@titan>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZLQgQAigmhk9uYYd@titan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 16/07/2023 18:52, John Watts wrote:
> Hello,
> 
> On Sun, Jul 16, 2023 at 06:36:03PM +0200, Krzysztof Kozlowski wrote:
>>> +static const struct sun4ican_quirks sun4ican_quirks_d1 = {
>>> +	.has_reset = true,
>>> +};
>>
>> Isn't this the same as previous?
> 
> Yes, but I wanted to split up the new quirk in to its own patch.

I don't understand why you need this new, duplicated entry. Aren't
devices compatible?


I also do not understand what 'own patch' has anything to do with it.

> Is
> there a better way of doing that?

Devices are compatible, right? So express it in the bindings and DTS.


Best regards,
Krzysztof

