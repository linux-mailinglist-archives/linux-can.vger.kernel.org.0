Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53E2DD447
	for <lists+linux-can@lfdr.de>; Thu, 17 Dec 2020 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLQPfO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Dec 2020 10:35:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34146 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLQPfO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Dec 2020 10:35:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BHFXQWP092045;
        Thu, 17 Dec 2020 09:33:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608219206;
        bh=Hq1TPKUKBSEzPHSc2bzBk37Aw189tDrvo2CYOyufzhM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YUdfAudyi2sYQ6buHYJ0s58TlumFpr9ViHuz0mXCvln00hzHUtrnqnIUPR3qUnyDe
         F1DhlmNmFPp1cZ7R6TigHYS3PionB7NMsZXkb4VGwOuKs9DKZPbMeNL2BkkSYwtR2i
         QEN9Z0KbdbD80msNETbLubunXER1tKWMDey8769c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BHFXQBs061735
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 09:33:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Dec 2020 09:33:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Dec 2020 09:33:26 -0600
Received: from [10.250.70.26] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BHFXP2F015327;
        Thu, 17 Dec 2020 09:33:25 -0600
Subject: Re: [RFC]: tcan4x5x: rework regmap support
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <kernel@pengutronix.de>, Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>
References: <20201215231746.1132907-1-mkl@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <80c6fe42-5524-0a3d-50de-761590fccc6a@ti.com>
Date:   Thu, 17 Dec 2020 09:33:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215231746.1132907-1-mkl@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/15/20 5:17 PM, Marc Kleine-Budde wrote:
> Hello,
>
> this series first cleans up the the SPI regmap and then fixes several problem:
> - tcan4x5x_regmap_gather_write(), tcan4x5x_regmap_read():
>    Do not place variable "addr" on stack and use it as buffer for SPI
>    transfer. Buffers for SPI transfers must be allocated from DMA save
>    memory.
> - tcan4x5x_regmap_gather_write(), tcan4x5x_regmap_read():
>    Halfe number of SPI transfers by using a single buffer + memcpy().
>    This improves the performance, especially on SPI controllers, which
>    use interrupt based transfers.
> - Use "8" bits per word, not "32". This makes it possible to use this
>    driver on SoCs like the Raspberry Pi, which SPI host controller
>    drivers only support 8 bits per word.
>
> With this series, the driver is able to detect a tcan4x5x on a Raspberry Pi.
>
> regards,
> Marc
>
Thanks for the clean up.

Reviewed-by: Dan Murphy <dmurphy@ti.com>

Dan

>
