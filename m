Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87327586D
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWNLe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWNLd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 09:11:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F6C0613CE
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 06:11:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bd2so6815474plb.7
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=OQNSTBovndhlbluSlvYuHVuXss9l7jQnMfNS/y8cAvU=;
        b=sqOv+4TgahIBisWF9TfOQNLnmqk/PHPVR6aQzvxh92M98Z8zCk184bgNM7W5VkOJn6
         7w3KXJcsMo7+2jP28hBNoBf8gCVh/9ddnj89ZCMZJgT2ygaw6tzxPBSu7zFX5L32UZ+f
         JNEGbeF3GmbU9ExlzKmwaDbTOcPPwXyAyUHI8F3WWTbxp52Qs4HY0g4/FW2Xl+BD6Rvy
         wmIbDuYEjIWrABJvDBNSDuMZoBUcodMmUKVCwEibxBmVILMEIupz+YZiPJ2nQaVL/7u4
         EL6zmvfAP5HRbOuPEzJMk/hmLbkDWp0kpSLcvpr3LzM3J3v/Yl5jSXhGRAAF28bhfMx/
         +8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=OQNSTBovndhlbluSlvYuHVuXss9l7jQnMfNS/y8cAvU=;
        b=N2xOh/yu6mcAQC9qm9rHWIyxs1EY6i5212gTlHnShKPqLCHZuXg4rEKTCyKBnhwN5T
         CH3TnQBIqeSzk17ZYWjPDDT3D6xYe0z3yqXcCsOjyiHiW9I88fwyfAJIlm2mu/1xB069
         N7WQAiWNAlK2eS/K+fqkm3J3d0NxWjIPzOEQU1UkXWzEpx+FekXKKpnIC9oahTgUC1u3
         YLnWBULVlOq6HLIvv9XsPT7cRBTAqtdw+R+EpgzGlSmokgIO9ZYevYXR0AnTpHjlZMCX
         NC8b7DRoIn6BXKTSHIfCDwBEdrW7jGne0LrZEym1PUkiaV0Zt5pFcc+nk28Bf78VD2ey
         f3yA==
X-Gm-Message-State: AOAM531nMCG9e5Y2LMWgouJ4s95dbFayLrwXTsb+gKhXTsjLMadUEdHf
        mc8ZV+OJxpj4hYa7lq1a6VbP
X-Google-Smtp-Source: ABdhPJxMwQwoAVm4x79UhRDtalgTKrTkEp/ZgfQBkxpe3IcXqKnm7acNv5jmbTkXopv1vFiQK/XfyA==
X-Received: by 2002:a17:90a:4802:: with SMTP id a2mr7945154pjh.5.1600866693183;
        Wed, 23 Sep 2020 06:11:33 -0700 (PDT)
Received: from ?IPv6:2409:4072:6d80:ea8c:4827:e640:206e:12? ([2409:4072:6d80:ea8c:4827:e640:206e:12])
        by smtp.gmail.com with ESMTPSA id y6sm5726744pjl.9.2020.09.23.06.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 06:11:32 -0700 (PDT)
Date:   Wed, 23 Sep 2020 18:41:26 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20200923114726.2704426-1-mkl@pengutronix.de>
References: <20200923114726.2704426-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp25xxfd: mcp25xxfd_irq(): add missing initialization of variable set_normal mode
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
CC:     Thomas Kopp <thomas.kopp@microchip.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <1180BAAE-FB63-4108-8741-2EB41F2066C3@linaro.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 23 September 2020 5:17:26 PM IST, Marc Kleine-Budde <mkl@pengutronix=2E=
de> wrote:
>This patch fixes the following warning:
>
>    drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec:2155 mcp25xxfd_irq()
>    error: uninitialized symbol 'set_normal_mode'=2E
>
>by adding the missing initialization=2E
>
>Reported-by: Dan Carpenter <dan=2Ecarpenter@oracle=2Ecom>
>Signed-off-by: Marc Kleine-Budde <mkl@pengutronix=2Ede>

Reviewed-by: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eorg>

Thanks,=20
Mani

>---
> drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec
>b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec
>index bd2ba981ae36=2E=2E912a73458a41 100644
>--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec
>+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core=2Ec
>@@ -2073,7 +2073,7 @@ static irqreturn_t mcp25xxfd_irq(int irq, void
>*dev_id)
>=20
> 	do {
> 		u32 intf_pending, intf_pending_clearable;
>-		bool set_normal_mode;
>+		bool set_normal_mode =3D false;
>=20
> 		err =3D regmap_bulk_read(priv->map_reg, MCP25XXFD_REG_INT,
> 				       &priv->regs_status,

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
