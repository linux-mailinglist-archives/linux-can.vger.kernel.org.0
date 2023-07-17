Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD46755BE4
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 08:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGQGkB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 02:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGQGkA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 02:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304BA93;
        Sun, 16 Jul 2023 23:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C172C60F53;
        Mon, 17 Jul 2023 06:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E34C433C7;
        Mon, 17 Jul 2023 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689575999;
        bh=5JoJzx5joWOWwC1I3CKZCIDyHqC15Ue/96/QUCSqZCg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j3noJRlY2sKqDkd7XXeOk7WmnSmVSHHg0IpqwJ6DqVRvrcH3nzuLwaDlmsGmOY+G6
         9vynavRO2zTFtTO0NJxPis/ea1Qq7dOifE9nl60PFlFiyQ4c+zAO6OIvh9HEGPfFEK
         saoPoV44vsu75DY8jTdx3j30M4eTRBDTE8VOzZehoh+HQuchGtaubssG2yRM3afguH
         r0fiA/2kNT2s+/viE+vjcH28zCcAm5G8+JnLWmct+L8kBgUsOcuWh5ko1S8vvuY6XL
         C7y7alMc6FqWe+IRV+cOuuCWvoGa6DiGmhrzlAw6MmgGM5ICUBvdTrJW00zysjqhKo
         iTORW+59fLJWA==
Message-ID: <9cd339c0-5e96-beba-e567-0a18d11d06b4@kernel.org>
Date:   Mon, 17 Jul 2023 08:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Content-Language: en-US
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-3-contact@jookia.org>
 <dd5d7fed-cda1-8ab2-d502-7466def675ac@kernel.org> <ZLQf5AYOCT3EQXyC@titan>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZLQf5AYOCT3EQXyC@titan>
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

On 16/07/2023 18:50, John Watts wrote:
> Hello,
> 
> Thanks for spending your time replying to this.
> 
> On Sun, Jul 16, 2023 at 06:35:17PM +0200, Krzysztof Kozlowski wrote:
>> On 15/07/2023 13:25, Jookia wrote:
>>> From: John Watts <contact@jookia.org>
>>>
>>> The Allwinner D1, T113 provide two CAN controllers that are variants
>>> of the R40 controller.
>>>
>>> I have tested support for these controllers on two boards:
>>>
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC (and consider --no-git-fallback argument). It might
>> happen, that command when run on an older kernel, gives you outdated
>> entries. Therefore please be sure you base your patches on recent Linux
>> kernel.
> 
> I ran this script and selected some of the emails and CCed them, at least I

So the others you skipped  Like let's pick this maintainer, but skip the
others? This is not how does it work. You are expected to CC all
maintainers (and to clarify the obvious: maintainers, not random
contributors). Some maintainers explicitly agree to be skipped, but
where do you see such statement from me?

Best regards,
Krzysztof

