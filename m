Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68264754FDF
	for <lists+linux-can@lfdr.de>; Sun, 16 Jul 2023 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGPQxV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 Jul 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGPQxU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Jul 2023 12:53:20 -0400
Received: from out-8.mta0.migadu.com (out-8.mta0.migadu.com [IPv6:2001:41d0:1004:224b::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11CEE52
        for <linux-can@vger.kernel.org>; Sun, 16 Jul 2023 09:53:17 -0700 (PDT)
Date:   Mon, 17 Jul 2023 02:50:44 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689526395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgi47nB1YHuMk/mfqwFLoSzUQApiiYJAouGt5+iloAs=;
        b=WnZ/73xFQ2KCJ2gdjOaHsIPEaibQl/fT9WyoisdiTJJDRianzEpge4xgk4hVAvCy4SlZKk
        jFlzmWDUIwn6KKON6QoiWuGYfQdbTRXq1MkhkQuhK0hWnuS0nz4YaTkfVhJTWuPvKPDQPY
        71J1zIdCPfif5Obbf9zxLcCOG8C9BzfcsaZyReXaMuOJWr9we+c7kxf0Q56/hwUXRezAP7
        xWcDC8BIM9dvxnN/OxEG9mQCFgh4p6EWpwQJirfy3b4xGNTUdY5B7Ex9VmS4h1yUuOMikN
        4mO/M3fSSX6hF2hQjd2Rcmaadsc6AMLL7zyx6v8lHVj/T4O4jh5Vh147UbfcAQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Message-ID: <ZLQf5AYOCT3EQXyC@titan>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-3-contact@jookia.org>
 <dd5d7fed-cda1-8ab2-d502-7466def675ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5d7fed-cda1-8ab2-d502-7466def675ac@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Thanks for spending your time replying to this.

On Sun, Jul 16, 2023 at 06:35:17PM +0200, Krzysztof Kozlowski wrote:
> On 15/07/2023 13:25, Jookia wrote:
> > From: John Watts <contact@jookia.org>
> > 
> > The Allwinner D1, T113 provide two CAN controllers that are variants
> > of the R40 controller.
> > 
> > I have tested support for these controllers on two boards:
> > 
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.

I ran this script and selected some of the emails and CCed them, at least I
believe that's what I did. Maybe I lost them when copying them to vim to make
the command line arguments.

> > +
> > +			/omit-if-no-ref/
> > +			can0_pins: can0_pins {
> 
> Wrong node naming. Underscores are not allowed.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

Hmm. I spent a few hours struggling and testing with make dtbs_check and
dt_binding_check. It doesn't seem to pick up on this specific issue, or at
least not in this case.

But yes I do see this, thanks for the catch. Will fix in v2.

I'm basing this patch series on 6.5-rc1, does that make a difference?

> Best regards,
> Krzysztof

Thanks,
John.
