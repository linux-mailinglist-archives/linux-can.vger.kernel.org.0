Return-Path: <linux-can+bounces-6951-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOYFK85/qWkd9gAAu9opvQ
	(envelope-from <linux-can+bounces-6951-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 14:06:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6182125EC
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 14:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE09300514B
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A83A1CEC;
	Thu,  5 Mar 2026 13:06:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F03A1A3D
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715976; cv=none; b=RRzwmp0BQzivzeXQIMGKB1fSc/zLphRI44b6ghCbLmT9hvLQccO0U87b4KVDO55Prvk2CcYkw/D3mXg1Ihw80/FaH3MFqfP0TT3GEkze7BkRsA4RssFcJWmwPcu/r2/HemKldcH/nxSDUXz+Kt0wpUvG4PP1iqmvK43dYidxKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715976; c=relaxed/simple;
	bh=An6z6pGF00+43VUaOecTwb49LKqdBH2wGqINr17mp5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyvwrTHj2NyMnhu4zelE5Rw3QrdKSo3D0KxHnbmwyyupEXRx9oagO2m4graLX1qV5jKRM1QnxMnOLnWCtrdKd4N5k3ZQP/eTZOtG4/O72UjR9K9urlgfHtnlNvEzw1Mv9i4S6o/5ldu/dfIKQWB+AGCY66VGlXBLUxtd3sCu4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad4d639db3so36414085ad.0
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 05:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715972; x=1773320772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/3ao61LTSp6jCCF+e+2SF+gp23jwVu9a+x2K0Dcxpg=;
        b=PG6/GvQb13a1xKNoQWg/SN6buNqiJ7/WRI0j7lgQgH2SUmpDf42MwDZyhVxQzHlGS6
         CiPO5tLfWf+B+2PRK8qAokky30zjSxN/5OnPkpQky2aYTvF7XmuAui+yKLkFVqlU45/1
         ZlScOIU0ycIlkRwlOJ8djr+XeYirJNbVHu38LB6SIQfClm3cAzVpXavDHVd7FeeGcST9
         093KcWeTnLONR8ec2BnFUvprc73/axvjKAkwo2ag89c3/bK6yCELXXSu8TibHalPNAQP
         IcAlO7mk0HXDO1FpmJmWQKQOGf7j8mMM06M/RqtSa7vkt3SNAcQ6Qe1m9SIknQlO4kGt
         6CmA==
X-Forwarded-Encrypted: i=1; AJvYcCUy5q8CNm0iHKPtsT2vLy0b9FHQ9OPzOqz8IsKTaKZEZON14BJ9D2s4wtw4/qugqDhkdJDyAD3GMYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIvX/KogdMxvvyPX5UBTP0GMytQVV5mkkV8v7AMfiOcfwOoAg
	4mn91xMoO1a/loGxgDaqRsCEuLD7PxxBq511JRRiO7KrcIvUhngMygTr
X-Gm-Gg: ATEYQzztVbMNRBAYjgSx3Q2A/4Sj9vMogpx/cd6IuMAOHPxl0nTXXKOdEG3kTPqiHB7
	9KbxoisKwkVRxVpytsnayTkWCCVXZKO7hyWUEEYWMbvzH6QMrVWUZcJWFGbKemcJW/KlUb8sCKE
	u3u5w4j8lCCmmXCdNjl6Wv3WZBWJt287w8QIGBRIPodhABeaItj027afyCYXnAeB+eueImskdgt
	lYayNGV2KQZI9gEBzSxekbQVp23GNsyNHC8PQAHkqDIILFaHobhCSPslRWDDhJvEcsyJAC7svIE
	87zKWz5TMDBixX328JHXkx9G15+3KeC/3lOFi7MTY5UGtgHwIACVta3aayjsKU/1XzCgMMSksRL
	FZapzfsAANs/T9p13jXeGmcnm+nv2qLMd5MjVPLvDfN9yKwBFNSC9WoCUCIYQlRQU0inDVtKkrh
	IGucSm+Sjvzu+19WBZ05BQZuS83WKffUJ91Es7p8/0Q4dw8zAs6J2VlkalkWbftt9akbMwijrl/
	yPP0QmDho3aF6v4b2purV2Hx1pQwICh19NwOqbwxyNdDDiAaxE=
X-Received: by 2002:a17:902:f68a:b0:295:560a:e499 with SMTP id d9443c01a7336-2ae6a9cd41cmr53596975ad.5.1772715971749;
        Thu, 05 Mar 2026 05:06:11 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d19559csm154128355ad.5.2026.03.05.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:06:10 -0800 (PST)
Date: Thu, 5 Mar 2026 22:06:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305130609.GB1659133@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305123843.i47asdrjychwlgdt@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305123843.i47asdrjychwlgdt@skbuf>
X-Rspamd-Queue-Id: 0D6182125EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6951-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kw@linux.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

> > > K:    \b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> > > K:    \bphy_(?:create|remove)_lookup\b
> > > K:    \bphy_(?:get|set)?_drvdata\b
> > > K:    \b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> > > K:    \bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> > > K:    \bphy_(?:init|exit|power_(?:on|off))\b
> > > K:    \bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> > > K:    \bphy_(?:reset|configure|validate|calibrate)\b
> > > K:    \bphy_notify_(?:connect|disconnect|state)\b
> > > K:    (?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> > > K:    (?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)
> > 
> > What about
> > 
> >   F:    drivers/*/*phy*
> > 
> > or something along these lines.
> > 
> >         Krzysztof
> 
> I don't understand your suggestion. Is it meant as a replacement for the
> keyword regexes? Your file pattern matches on:

I was thinking more along the lines of using wildcards, the F: was just an
example.

[...]

> There are a lot of false positives, and a lot of false negatives.

Yeah, the "catch-all", for lack of better word, will not work here.

	Krzysztof

