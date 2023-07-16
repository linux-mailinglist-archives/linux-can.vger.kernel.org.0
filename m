Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3B754FD1
	for <lists+linux-can@lfdr.de>; Sun, 16 Jul 2023 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGPQgL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 16 Jul 2023 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjGPQgK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Jul 2023 12:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DEBDE;
        Sun, 16 Jul 2023 09:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855CF60DB4;
        Sun, 16 Jul 2023 16:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E900C433C8;
        Sun, 16 Jul 2023 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689525369;
        bh=lfHQs1QwpReacQf4a7V29m1UNZ+jaDDuhifycOp+VJw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s1tpv+SEjLYE+7wws9zlRxVah7idFtwiUgWPTwwKmakHIhUkFpS5HQ+X3AD9wJ9oE
         QlsZNn4rPy7913Vm5Phor4eAPcJl+s+2OFEJ+ic2XtHSywyZiTvHP9sKvj0dUhT2Hr
         BJEDOecAkYwS7SrhP6hxY2GnekJa2u7cMU9Tk9Sd7s9JREY4MptfG87yxp+p9rIPyg
         VJ23cWbSVNeIBltpkUv4oCwERz92NIvHMU2tVpmIe9wsWEMoi56zyW4KTDoi5XCnHo
         ygVXPwXdmePnZjCSCM5mY0+eBGCUOGGZq+BC6glVR7/NVeCGqqwqHkzLMgJOKkZt5A
         7u7+ukj5Zmx6A==
Message-ID: <f3b1240a-4be0-4c02-0a63-561499ad6d0d@kernel.org>
Date:   Sun, 16 Jul 2023 18:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] can: sun4i_can: Add send support for the Allwinner D1
Content-Language: en-US
To:     Jookia <contact@jookia.org>, linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-4-contact@jookia.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230715112523.2533742-4-contact@jookia.org>
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

On 15/07/2023 13:25, Jookia wrote:
> From: John Watts <contact@jookia.org>
> 
> The controllers present in the D1 are extremely similar to the R40
> and require the same reset quirks. This alone can support sending
> packets. An extra quirk is needed to support receiving packets.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  drivers/net/can/Kconfig     | 4 ++--
>  drivers/net/can/sun4i_can.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index a5c5036dfb94..e626de33e735 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -185,10 +185,10 @@ config CAN_SLCAN
>  
>  config CAN_SUN4I
>  	tristate "Allwinner A10 CAN controller"
> -	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
> +	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
>  	help
>  	  Say Y here if you want to use CAN controller found on Allwinner
> -	  A10/A20 SoCs.
> +	  A10/A20/D1 SoCs.
>  
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called sun4i_can.
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index 0827830bbf28..06f2cf05aaf5 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -774,6 +774,10 @@ static const struct sun4ican_quirks sun4ican_quirks_r40 = {
>  	.has_reset = true,
>  };
>  
> +static const struct sun4ican_quirks sun4ican_quirks_d1 = {
> +	.has_reset = true,
> +};

Isn't this the same as previous?

Best regards,
Krzysztof

