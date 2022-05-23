Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75153142D
	for <lists+linux-can@lfdr.de>; Mon, 23 May 2022 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiEWPPS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 May 2022 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiEWPPQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 May 2022 11:15:16 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DB449FB4
        for <linux-can@vger.kernel.org>; Mon, 23 May 2022 08:15:14 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 2895930B2952;
        Mon, 23 May 2022 17:15:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=53z/W
        SEz+3FKSfD9NMlxU/1GaQ2/atA2SXWFedwtlmo=; b=WT1YOSVlS1Jdoua8nfG74
        ZIiIIQ+6qV7jYv64s19nn+3/LSsQO+BkWPEHP9O8lcqk8klfc7OS7NMVo5Bav/on
        oZIoQYKGZ2ep3VKyJJOCxpL6/+1zvAC9TJNzA8dC2n7NegrvxDvOb21X71j2Rxzq
        cD4UJycDnQ1TST3Ui0kTcD1GEHQP9rWjq/7R9K2JbbKyKI+znFgyP4HO2Yvs1l8J
        5193+mkAtBXdjERqNoYvUmfGTTD9+pmH9ZD//q5gNLvsP7YQ5AsuO2vm/B5nYWrE
        IdbDDuqNnc5k0oIpdPdJZevqcsEptbyUH9cxpxKZjnXKuoxSTS+tCgySj4GkCmvV
        Q==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 3704A30AE004;
        Mon, 23 May 2022 17:15:11 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 24NFFB0D012408;
        Mon, 23 May 2022 17:15:11 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 24NFFA56012407;
        Mon, 23 May 2022 17:15:10 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ctucanfd: platform: add missing dependency to HAS_IOMEM
Date:   Mon, 23 May 2022 17:15:05 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Matej Vasilevski <matej.vasilevski@gmail.com>
References: <20220523123720.1656611-1-mkl@pengutronix.de>
In-Reply-To: <20220523123720.1656611-1-mkl@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202205231715.05788.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

thanks much for correction.

On Monday 23 of May 2022 14:37:20 Marc Kleine-Budde wrote:
> The kernel test robot noticed that the ctucanfd platform driver fails
> during modpost on platforms that don't support IOMEM.
>
> | ERROR: modpost: "devm_ioremap_resource"
> | [drivers/net/can/ctucanfd/ctucanfd_platform.ko] undefined!
>
> This patch adds the missing HAS_IOMEM dependency.
>
> Fixes: e8f0c23a2415 ("can: ctucanfd: CTU CAN FD open-source IP core -
> platform/SoC support.") Reported-by: kernel test robot <lkp@intel.com>
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz> (maintainer:CTU CAN FD DRIVER)
> Cc: Ondrej Ille <ondrej.ille@gmail.com> (maintainer:CTU CAN FD DRIVER)
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  drivers/net/can/ctucanfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/ctucanfd/Kconfig
> b/drivers/net/can/ctucanfd/Kconfig index 3c383612eb17..6e2073351a8f 100644
> --- a/drivers/net/can/ctucanfd/Kconfig
> +++ b/drivers/net/can/ctucanfd/Kconfig
> @@ -23,7 +23,7 @@ config CAN_CTUCANFD_PCI
>
>  config CAN_CTUCANFD_PLATFORM
>  	tristate "CTU CAN-FD IP core platform (FPGA, SoC) driver"
> -	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM && (OF || COMPILE_TEST)
>  	select CAN_CTUCANFD
>  	help
>  	  The core has been tested together with OpenCores SJA1000

