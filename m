Return-Path: <linux-can+bounces-6252-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IQwNAXBcWmQLwAAu9opvQ
	(envelope-from <linux-can+bounces-6252-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 07:17:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6F62334
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 07:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13F294C65E3
	for <lists+linux-can@lfdr.de>; Thu, 22 Jan 2026 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556E47AF44;
	Thu, 22 Jan 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCEo8lZK"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F952222A1
	for <linux-can@vger.kernel.org>; Thu, 22 Jan 2026 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062651; cv=none; b=FgkPYVoKKXdYBAwZPVl+eZ8G5AH5wlePWhhSG6DmmO8nVogopyVvpU04m3YdwTEgxhKyIiOT00RUdIbfelTv0iQ2hi9XrhT86DAW8SxMnqm4KUgjaqHpAud4Pci+PSW0DDy4h1n5qwBoyzkqV/FfoVsjK4AqDuoBQPI/b2rRzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062651; c=relaxed/simple;
	bh=HwQQ/e13d2XeVp13BFe2FpMedQM5DZhp8KcD4K71ego=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UUEkWGMqQb8VPANARpPdNBQAGm872pm21Cdwz0vVAwt3CpckhBAKW0Hfo70qVDkTpHEGqs6pUoW9h8Kfbiy2C7Bd4h/4Ij2nQWipvwqxq4XkTRN3gesoBwzAfcHItc4E9MmpAXm/56BEt7is8t24Fyysq7lvKd14BrBZFzN4s4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCEo8lZK; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so5706525e9.3
        for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 22:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769062644; x=1769667444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFWxi+AFltNFDVpcrpAcnDmVTxmCRVFES1AkiIw22SY=;
        b=cCEo8lZKAs1wr4lfPYM6lISHc7OyocCVXHgQM1twwkXLb2NuRB1HERaaxW76fYKOgR
         Kv9d/riU2OCb5wtfxfGlcANv57LjTxWKE/VrxnT/EMzxLh+ZAtT99J00GtjHh/KR8S4H
         7MHMP7DnxML999Bi32tWLzr9OZISoLZDdJd9644F++z6At/8GHg3JQEG5GpMQKOJrnyh
         c7/vuVQ9CMDAM2UjiUYpfX5tnOaHhPIn/ynUJ6NfW1bsDsxriBKfbdNSnKcZL100q8a3
         81xHngoT8wYXu4xVfTTg0hCauJDEExfpnclEk4qxnchsokJMNLy6sERO2HSZVj1o8xbb
         bTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769062644; x=1769667444;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFWxi+AFltNFDVpcrpAcnDmVTxmCRVFES1AkiIw22SY=;
        b=BvdkYUzgOSqG+nx02G8F595zncIl/z4Xb14QI8MsRRaG1L0hykeXTyv6d7gP7AaMXv
         ThYVivbKyxFlO6wxeyAXnjLiAkousDt5z8a3LZGztDzbvki2DuljTKIAgPV+7B7xvxFE
         4j8Kq5oU9U10cIntFvvL7TndpedNS6J4Jt5MUdzPxIETgB/V3XBoMctCWU6bsvETniqo
         eleLasVKu6gM1YIa9lIjEDhtQz3c6s6l3Ztux3ubXQon9+fOccRNxz7A2XDn/ri4Ilfs
         pSeObmin/9yBWEsQRbug/OMSay2fVovbbgVQxBtmZiHV6VTkNYsHJfeyhsqeEyH67UH5
         D2dg==
X-Forwarded-Encrypted: i=1; AJvYcCWBnSNFJAiyMIvcznd3hUUIltGuS/HjX3izIkvToHsauQ48b8ZBBYfE2NdKPey8nz/iiyoesuFmPVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmgXMMVWk0sCwY2rrTl6jN+0ipOWg/j9iE9Xh3yKte1JVXNTH
	jAcdaYE4gj16Xcnl/MU1mXdrkWToF5wI4T4RnuOb9D90zW0MRezXmlPckfbGlK4RaEw=
X-Gm-Gg: AZuq6aJJci0ndYeU0DIIz3l19WP0V4hVa4eGMwTwNaPgZtd2TdhgWJH5FOhaFpPcMw2
	vjezBaGlebzdjOoBwDNsmrgaoOipSBRytpjmuSRMs2vGs0AkFM3AHYw0NWp35JGdItbvjZ2emcn
	WjKzezOsFLUg7fbnQm9DbT8h0i60XjshjxRDa1HSwio+jvUYINI50kWfbzpd5ysEASZ1hgu4dvH
	at2GMzuBn0oVbHE3UW0nrK0+HzoZ1z2+5qq3Bty0R1gy6BN092le6lqPNxuAqeiUk2ldDFblGDE
	LbXJPxGmrVfBCd1PjpcX3NPxBdaz+6dK/+WPwfe5tsNi6YvyRo6nM8ssougV7Re1Q+dExiDYKeY
	KbE7acda1E+d3gQ7y60yH0hoUcLT9KrHVf/jJG3fjLjjDrPfOLnhmd5mUJXKbAcbz6CeK/5rugB
	Hx0LZKlMkacqiDxILH
X-Received: by 2002:a05:600c:83c8:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-48028360726mr235733975e9.7.1769062643924;
        Wed, 21 Jan 2026 22:17:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b89bsm40122255e9.9.2026.01.21.22.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 22:17:23 -0800 (PST)
Date: Thu, 22 Jan 2026 09:17:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Josua Mayer <josua@solid-run.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <202601221036.J0kR78Uw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-rz-sdio-mux-v6-2-38aa39527928@solid-run.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6252-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.linux.dev,solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 7CD6F62334
X-Rspamd-Action: no action

Hi Josua,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transceiver-rename-temporary-helper-function-to-avoid-conflict/20260121-173607
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-2-38aa39527928%40solid-run.com
patch subject: [PATCH v6 2/7] mux: Add helper functions for getting optional and selected mux-state
config: arm64-randconfig-r073-20260121 (https://download.01.org/0day-ci/archive/20260122/202601221036.J0kR78Uw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601221036.J0kR78Uw-lkp@intel.com/

New smatch warnings:
drivers/mux/core.c:776 __devm_mux_state_get() warn: passing zero to 'PTR_ERR'
drivers/mux/core.c:796 __devm_mux_state_get() warn: passing zero to 'ERR_PTR'

Old smatch warnings:
drivers/mux/core.c:722 mux_state_get() warn: passing zero to 'ERR_CAST'

vim +/PTR_ERR +776 drivers/mux/core.c

0610cc3159b786 Josua Mayer       2026-01-21  761  static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
0610cc3159b786 Josua Mayer       2026-01-21  762  					      bool optional,
0610cc3159b786 Josua Mayer       2026-01-21  763  					      int (*init)(struct mux_state *mstate),
0610cc3159b786 Josua Mayer       2026-01-21  764  					      int (*exit)(struct mux_state *mstate))
0610cc3159b786 Josua Mayer       2026-01-21  765  {
0610cc3159b786 Josua Mayer       2026-01-21  766  	struct devm_mux_state_state *devm_state;
0610cc3159b786 Josua Mayer       2026-01-21  767  	struct mux_state *mstate;
0610cc3159b786 Josua Mayer       2026-01-21  768  	int ret;
84564481bc4520 Aswath Govindraju 2022-01-07  769  
0610cc3159b786 Josua Mayer       2026-01-21  770  	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
0610cc3159b786 Josua Mayer       2026-01-21  771  	if (!devm_state)
0610cc3159b786 Josua Mayer       2026-01-21  772  		return ERR_PTR(-ENOMEM);
0610cc3159b786 Josua Mayer       2026-01-21  773  
0610cc3159b786 Josua Mayer       2026-01-21  774  	mstate = mux_state_get(dev, mux_name, optional);
0610cc3159b786 Josua Mayer       2026-01-21  775  	if (IS_ERR_OR_NULL(mstate)) {

Please, change this to if (IS_ERR(mstate)) {.  The mux_state_get() never
returns NULL.  I have written a blog about functions which return both
error pointers and NULL.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

0610cc3159b786 Josua Mayer       2026-01-21 @776  		ret = PTR_ERR(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  777  		goto err_mux_state_get;
0610cc3159b786 Josua Mayer       2026-01-21  778  	}
0610cc3159b786 Josua Mayer       2026-01-21  779  
0610cc3159b786 Josua Mayer       2026-01-21  780  	if (init) {
0610cc3159b786 Josua Mayer       2026-01-21  781  		ret = init(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  782  		if (ret)
0610cc3159b786 Josua Mayer       2026-01-21  783  			goto err_mux_state_init;
0610cc3159b786 Josua Mayer       2026-01-21  784  	}
0610cc3159b786 Josua Mayer       2026-01-21  785  
0610cc3159b786 Josua Mayer       2026-01-21  786  	devm_state->mstate = mstate;
0610cc3159b786 Josua Mayer       2026-01-21  787  	devm_state->exit = exit;
0610cc3159b786 Josua Mayer       2026-01-21  788  	devres_add(dev, devm_state);
0610cc3159b786 Josua Mayer       2026-01-21  789  
0610cc3159b786 Josua Mayer       2026-01-21  790  	return mstate;
0610cc3159b786 Josua Mayer       2026-01-21  791  
0610cc3159b786 Josua Mayer       2026-01-21  792  err_mux_state_init:
84564481bc4520 Aswath Govindraju 2022-01-07  793  	mux_state_put(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  794  err_mux_state_get:
0610cc3159b786 Josua Mayer       2026-01-21  795  	devres_free(devm_state);
0610cc3159b786 Josua Mayer       2026-01-21 @796  	return ERR_PTR(ret);
84564481bc4520 Aswath Govindraju 2022-01-07  797  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


