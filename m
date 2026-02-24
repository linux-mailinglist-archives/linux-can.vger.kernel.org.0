Return-Path: <linux-can+bounces-6617-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJGfOinRnWn4SAQAu9opvQ
	(envelope-from <linux-can+bounces-6617-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 17:26:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B83189C6F
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 943CA3049529
	for <lists+linux-can@lfdr.de>; Tue, 24 Feb 2026 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894733A7F44;
	Tue, 24 Feb 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFIO/Il2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928C371047
	for <linux-can@vger.kernel.org>; Tue, 24 Feb 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950372; cv=none; b=hY1dL4iqjDyTLWebOlor0BXeU5tuKmwVgXD6MGn/cwufo+PPI/wVVGan929QMu/XRVui8yPhMbvsqzL+uxYVdP1CYlIlPobs9V7gmk/9tasY5bRS7ZIbP8R3lHMsB8vBcaTaAMld2ii0V6Ys7GkhaO/nWFjtVx0/H9rm8Fid1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950372; c=relaxed/simple;
	bh=W2nQxrtiD8XUcZjZAJH/7f/U/tHXDj+eqBIaSOhQ4Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUluYpucy4JK1Ldec4IQMFengk2cOzg62wPKdgAzcNoed8+7yhwtC4uCHPM7FEHQ0w/keTOTVIf1JAUB3dNZrgmxf+BNo3H3IE48b9XWoan8Q48iBTxGFiyj9kxjjkxi1bk3wavZB8j9sOwr5SO7FJx8fat/bALSBMhl+gUtVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFIO/Il2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43637371266so332484f8f.2
        for <linux-can@vger.kernel.org>; Tue, 24 Feb 2026 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771950369; x=1772555169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UJCCAJ5+VhuXYvQW4umc3jIBzl7EEXxPBo7h1hHDXA=;
        b=UFIO/Il2ujHSGJGViy1S4ys5sX3sjnrQ2wv+XkSPjrMX89qUbgzydrG53Y3TGXPSEo
         MQFxz+RfH0VdFu8XV7pOBIBCEv1l/s8IB9qKydfFxeQkyZYYRFsdAX3B7bO3S0WeG1QB
         zBok1cmttagLQJSH4r4Lfn98KJ31JpI9jUX78ifb25hJgR2bjICsRv6e/8mthinBlICX
         sIzSYzXM5y5ETHVTKBnwYLm4E0RAtLeglNVm0qhtMeHGLP9dlu+T5SNW4M1VjCvQLzcC
         2TUGzdXcrCpDiiyXZrvcGWPetBbi2rb7AwabW53eQLYR1Ca97c7GEKiRactZ7/LEsVer
         OyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771950369; x=1772555169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UJCCAJ5+VhuXYvQW4umc3jIBzl7EEXxPBo7h1hHDXA=;
        b=dkxDXiNKOAayxqKITmY08jSvgB1AQfIgS70CEm3lS45WaOXxhUMOawHcUetBBee9WV
         /JLXg6FW6zyMKKqcnF2st3BOBMiL+iNj4KEdgyltH9gakxrM71UIW1psRYtUhkUIUuQb
         klZdt4iA25ErIoTmYm/v7ErkmD4hqniWWJIDq8SedFqtaLBJt/ILiqz0AVN3tFbAHl7e
         6qLSHrxjBdU2RPwW4pW8EoXNvXc1xhcGNYofnjzMSk84ClAanUbFapNsmHHepPDVGUNa
         DLgdSV9KFRDcEvb78oaGTOUDg0q3gUN+I8j2A23aYD46cu95wLodF2qwMtB12zRL4WM4
         TBQw==
X-Gm-Message-State: AOJu0Yzr90gfNZos/k8EqPrLItDPHYfooey81mhjUTQzsTgPaa5t7I1k
	z0dBFI88pY/cx8hQlGAn6FHBkHXcFNHZpcG2Fg9aE8yW7HmS8zX2HOFTYzrsow==
X-Gm-Gg: ATEYQzxXUrwOTsr9zYoX8yyybT7V/pfrrYhi0h/tDNO7YNzmPm2LLEsNUCLAmSNwkd2
	xAt09Sa9vEMUJ9U1QKGtUzfTaJCcgsEqYqgREYDPYAzZbi1jUnRvUcOUH0OfWkL/itKsBEu64XN
	RocidjefJ/4U4iLqqashq39TOamLPfl/IuyA3+vYGdlQ3ZVTN38NA6uGmxvpvKHRdJ/xhZF/nCj
	DiwkpxOZ34H+i7F6ZftLhyR4PMfBeQCNNdXmy1Sa6RgToe6WNdVC5iG7GioN/ZIr2r6DO/QdVlD
	4djNDwdFY017DhhNhWMNz4uCSzIAd1lQIcnNjHcuhwD+X/kwKBCI3RhdZa8YE+SnJXzVsGtFXrk
	hdR1fwakqC6iKwrDSRsQbrtL1CwTLMuxqS98kx4DRLUpPbJvZKcfhxFD6ayl3EQu4sTTJP2nGlq
	qy+aislymM8kfckm4=
X-Received: by 2002:a05:6000:2301:b0:431:8f8:7f2a with SMTP id ffacd0b85a97d-4396f156c01mr13242241f8f.1.1771950369200;
        Tue, 24 Feb 2026 08:26:09 -0800 (PST)
Received: from skbuf ([2a02:2f04:d809:4b00:7cd9:3431:5b61:7303])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9fb2sm28510048f8f.1.2026.02.24.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:26:08 -0800 (PST)
Date: Tue, 24 Feb 2026 18:26:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v1 1/4] phy: phy-can-transceiver: Convert to use device
 property API
Message-ID: <20260224162606.spnzzedvmvp2h7xd@skbuf>
References: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
 <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6617-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 65B83189C6F
X-Rspamd-Action: no action

Hi Andy,

On Thu, Feb 19, 2026 at 09:26:19PM +0100, Andy Shevchenko wrote:
> It seems the driver is half-moved to use device property APIs.
> Finish that by converting everything to use that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 330356706ad7..f2259af4af8a 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -5,9 +5,9 @@
>   * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
>   *
>   */
> -#include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/module.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
> @@ -130,7 +130,7 @@ MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
>  static inline struct mux_state *
>  devm_mux_state_get_optional(struct device *dev, const char *mux_name)
>  {
> -	if (!of_property_present(dev->of_node, "mux-states"))
> +	if (!device_property_present(dev, "mux-states"))

There's an entire saga with this function - devm_mux_state_get_optional().
Josua Mayer is preparing to move it to the MUX core, which will be a cross-tree series.
Would you mind not touching this, to avoid complicating what is already
a complicated operation? It is going away anyway, and from what I can
see in Josua's last series, its implementation from drivers/mux/core.c
is already using device property APIs:
https://lore.kernel.org/linux-phy/20260208-rz-sdio-mux-v9-2-9a3be13c1280@solid-run.com/

>  		return NULL;
>  
>  	return devm_mux_state_get(dev, mux_name);
> @@ -162,7 +162,6 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	struct can_transceiver_phy *can_transceiver_phy;
>  	struct can_transceiver_priv *priv;
>  	const struct can_transceiver_data *drvdata;
> -	const struct of_device_id *match;
>  	struct phy *phy;
>  	struct gpio_desc *silent_gpio;
>  	struct gpio_desc *standby_gpio;
> @@ -171,8 +170,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	u32 max_bitrate = 0;
>  	int err, i, num_ch = 1;
>  
> -	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
> -	drvdata = match->data;
> +	drvdata = device_get_match_data(dev);
>  	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
>  		num_ch = 2;
>  
> @@ -197,7 +195,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  		can_transceiver_phy = &priv->can_transceiver_phy[i];
>  		can_transceiver_phy->priv = priv;
>  
> -		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
> +		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);

It is not obvious why you replaced dev->of_node with NULL here.
It doesn't appear correct. You seem to be breaking OF-based PHY lookups.

>  		if (IS_ERR(phy)) {
>  			dev_err(dev, "failed to create can transceiver phy\n");
>  			return PTR_ERR(phy);
> -- 
> 2.50.1
> 
> 


