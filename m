Return-Path: <linux-can+bounces-709-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B58FFA2B
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 05:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6A2840D3
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A115491;
	Fri,  7 Jun 2024 03:26:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9112B73;
	Fri,  7 Jun 2024 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717730787; cv=none; b=SnlDNbOGijQHCjMNfgTsppf/ubh85aTKy2wZqVVhQ9EZpwfqJG9nmRRYgzxlquCFauEv3dzBdOXlq+VgdqHjPvW6hWBHo9N50wOqf+YoLUM5lLc74IWZbTtmDe6QhYZIety3aJ0eP4Yv4w9H4xgsXcfhXx1VqxqpKtPXU9mPSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717730787; c=relaxed/simple;
	bh=og1W7CQ5dnT/fxo+VgP79WpVi3mZdb507tWx9OolfGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GW+J5b+tsAwfcjdg+fUjvlzWpcvYWwSnaS10RIN3UHlsE4CU4pldvJc4ZsPezk1VE1wFRTHJreOZ5qkvsCE+pYnqLDkIicWHlCpm4In/Qkmq9OBxj4l016oK1cXyAxFrG7evR+cFewi0ZCKqaSde57IUGgCkpAwVud17q+Pc51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f68834bfdfso13070705ad.3;
        Thu, 06 Jun 2024 20:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717730785; x=1718335585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRHXhwV5J6FLgsfFL2J905n4RcD+iK2n31FrCkpHF6A=;
        b=nlskBK4kyU+QCtqgI0F2vqhUQvddldDhXR84XmNtxZPNN8RMB4NlS4FZ5rYW+D0Le6
         xoYGMFSZ1qFSidIxNEDDrg/GyaZHJ5gBfVE7O7VbjcMzctlIDabt13ab39Mob1sKHKDb
         ySkk/2EYJQImmuGmZPxzAtujCHYxO/BMfhPMSTQbN4YoU2xVUE/sKF7PAbDTFNyQw+AM
         nwHyRA86IDCDwFV7rbWJ2vtngOvHecIbid/0FMCEl4xCpvnk1YgL+h6Iszhpeeg7Xf3T
         S8Yy7UT5CRAoaAwFCfz1xAsnjSAy9NwB/W8fKATQrjxZBR5lAkGAcEgDUjx8xQEDA3lr
         BM7w==
X-Forwarded-Encrypted: i=1; AJvYcCX8v+Es8ODsJjbg8lsIe/xPN/scSUj+rSdhF/BLGUxFs7tjnPxyOLjVoabFXUIUMiSgfRY0ZqmTnrNb03+2p3hS3f7FptGF9LOViEPDRKItnhpsKuF51ApgH2lAmIdvTf1yVg5LG2NxaHwIQqV3EC6QgVbqGX2THVJQw9NSerj8
X-Gm-Message-State: AOJu0Ywqdk9MQNj5vxMRy7/oM13IYGaGxWgMSWj+wDJitzi+uk7HiHf2
	PC0SMsYZsHsvLFrT3kRHQfilW0d8+lZvh+b9ZMQa9yNFBGnvFm+jRHAo2Z8ljUwJk4+lIL83HoV
	MRphVgxfdo9hJcmJE1yd7Uu8qHXs=
X-Google-Smtp-Source: AGHT+IEcC+4RIunglw2wr0+8bQvV2bXA9Hu1tE0poFcN42DMBYLae/uLzBgvCm76tx8Dvg1VFSiJojtDZRkQneEAg+8=
X-Received: by 2002:a17:903:2b0e:b0:1f4:5dc0:5fe8 with SMTP id
 d9443c01a7336-1f6d02e22efmr16652065ad.15.1717730785287; Thu, 06 Jun 2024
 20:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Fri, 7 Jun 2024 12:26:13 +0900
Message-ID: <CAMZ6RqKCWzzbd-P7rOMEryd=31pdD_PJJvtQFYcmS+wAf8q+CQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] can: hi311x: simplify with spi_get_device_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu. 6 Jun. 2024 =C3=A0 23:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Use spi_get_device_match_data() helper to simplify a bit the driver.

Thanks for this clean up.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/net/can/spi/hi311x.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index e1b8533a602e..5d2c80f05611 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -830,7 +830,6 @@ static int hi3110_can_probe(struct spi_device *spi)
>         struct device *dev =3D &spi->dev;
>         struct net_device *net;
>         struct hi3110_priv *priv;
> -       const void *match;
>         struct clk *clk;
>         u32 freq;
>         int ret;
> @@ -874,11 +873,7 @@ static int hi3110_can_probe(struct spi_device *spi)
>                 CAN_CTRLMODE_LISTENONLY |
>                 CAN_CTRLMODE_BERR_REPORTING;
>
> -       match =3D device_get_match_data(dev);
> -       if (match)
> -               priv->model =3D (enum hi3110_model)(uintptr_t)match;
> -       else
> -               priv->model =3D spi_get_device_id(spi)->driver_data;
> +       priv->model =3D (enum hi3110_model)spi_get_device_match_data(spi)=
;

Here, you are dropping the (uintptr_t) cast. Casting a pointer to an
enum type can trigger a zealous -Wvoid-pointer-to-enum-cast clang
warning, and the (uintptr_t) cast is the defacto standard to silence
such warnings, thus the double (enum hi3110_model)(uintptr_t) cast in
the initial version.

Refer to this thread for examples:

  https://lore.kernel.org/linux-can/20210527084532.1384031-12-mkl@pengutron=
ix.de/

Unless you are able to add a rationale in the patch description of why
this cast can now be removed, I suggest you to keep it:

          priv->model =3D (enum
hi3110_model)(uintptr_t)spi_get_device_match_data(spi);

>         priv->net =3D net;
>         priv->clk =3D clk;

Yours sincerely,
Vincent Mailhol

