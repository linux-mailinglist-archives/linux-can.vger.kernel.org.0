Return-Path: <linux-can+bounces-7057-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNkzDtWFr2lvaAIAu9opvQ
	(envelope-from <linux-can+bounces-7057-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 03:45:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5924451A
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 03:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A0D3058DD5
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92A3ACF0B;
	Tue, 10 Mar 2026 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYQ4GzGr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E23AA1B4
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110716; cv=none; b=EGjdVM36u5yvEjsgEqgV4OAgJxkKkzyp4HEMbyKW69RzVIFl3jJz74IdwtNgLhzGJc0GpcNo/0aL7i/9pvlHN/bZblAGI6cIZvzH1R8DvqrxNMYtAN/PqXs/snPICogS1v1xOVAR2FPEg3RR5xTmLcnwmjxnvngh+PYwnH4UkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110716; c=relaxed/simple;
	bh=AiuSbGc4gyF+r0NsVvYBegnqTPdAIt4V0L/szs51RLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1yGtiQVYW2piZ0m4Bfqtv7i+3Sw/pCAuKW+9ec/73CPQ0tHInggCb0fjuGUkhdX2yIAZYdR2NqKc9HvlRvzH84Dl0lAxOQcupCg9PXRj/87N4u6QJEAYl6Z4vsBVpjSdxpfM9m7NiYSVuKxP3RobTu3D4G7NnhfTz/oRP5d6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYQ4GzGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DB4C2BCB5
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 02:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773110715;
	bh=AiuSbGc4gyF+r0NsVvYBegnqTPdAIt4V0L/szs51RLs=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=OYQ4GzGrjp8DJFWsl2mM6ocePlwxv12ixt2gG1IoJH8dIMcy2K9jYlYp0xrXUr1hj
	 vdJ1Hmp0SjmxQ+VCPPiqJlGt8YHvrtJ6IjbgXtVQ4LMZbCg9LwXbL8lu4+PBO7sjsL
	 4s38j0P9Pc/iUqjSuchyjIAcNbjA/RLX+hPcWwe8rEaxzhE3zj7CNgU19ws9MZxPyz
	 jVvlhgVmpbBARm+YBqB5I7YjjmX/kwY2NwSC8hyTJgVaSFIJVMQTWw9r0B2mnIUaZ+
	 dgdQe+dNt9cNuRA9+q+H8NVNiXnbOpLUOvVf27C6ZPPIJpRz4lQ5Rxab9sF8pu86xC
	 ckfjVXnxFH4qg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a4118c4f7so43022891fa.2
        for <linux-can@vger.kernel.org>; Mon, 09 Mar 2026 19:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq9mMpTS+Hrrd0AT9zU4zLBVEEjivyBHAwnaF+LR2x4U5Y66OGOV39bOywJmNigvoGzsHksEpXvak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMw1mnqYqNwrkmyygAx8fWD9i/V3EHwlBF1mZaX+Pv6S/ka6p4
	aX24SAA4gE/6XunoHKxcts5KKq5BFfen80WTeX0Z0DM5aldWxpaIl5TpMr3bas0qh3B/wHYGp7s
	W+gQt07dmwiLAIeXJwtmDd0agySyU/E8=
X-Received: by 2002:a05:651c:1104:b0:385:c21f:37e1 with SMTP id
 38308e7fff4ca-38a40b6a2d2mr40186201fa.15.1773110714064; Mon, 09 Mar 2026
 19:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309190842.927634-1-vladimir.oltean@nxp.com> <20260309190842.927634-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260309190842.927634-18-vladimir.oltean@nxp.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 10 Mar 2026 10:45:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v65surpnqrmv4tbH4TSrx6SaTpdbsQtCsNqwse5xwdb8fA@mail.gmail.com>
X-Gm-Features: AaiRm535EaFxYtCAjq5FIkHiBmgOxc7_e434rO98DZfg5NrM7RTttw3IOCzqW1Y
Message-ID: <CAGb2v65surpnqrmv4tbH4TSrx6SaTpdbsQtCsNqwse5xwdb8fA@mail.gmail.com>
Subject: Re: [PATCH v3 phy-next 17/24] media: sunxi: a83-mips-csi2: include
 PHY provider header
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4A5924451A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,gmail.com,sholland.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-7057-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 3:10=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> The introduction commit 576d196c522b ("media: sunxi: Add support for the
> A83T MIPI CSI-2 controller") says:
>
>     This implementation splits the protocol and D-PHY registers and
>     uses the PHY framework internally. The D-PHY is not registered as a
>     standalone PHY driver since it cannot be used with any other
>     controller.
>
> However, this does not matter, and is not the only instance of tight PHY
> provider <-> consumer pairing. According to Vinod Koul, having PHY
> provider drivers outside of drivers/phy/ is discouraged, although it
> would be difficult for me to address a proper movement here.
>
> So just include the private provider API header from drivers/phy/ and
> leave a FIXME in place.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

> ---
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Chen-Yu Tsai <wens@kernel.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
>
> v1->v3: none
> ---
>  .../media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t=
_dphy.c b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy=
.c
> index 24bbcc85013d..1143feeb4fcb 100644
> --- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
> +++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
> @@ -4,9 +4,9 @@
>   * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>   */
>
> -#include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>
> +#include "../../../../phy/phy-provider.h" /* FIXME */
>  #include "sun8i_a83t_dphy.h"
>  #include "sun8i_a83t_mipi_csi2.h"
>
> --
> 2.43.0
>

