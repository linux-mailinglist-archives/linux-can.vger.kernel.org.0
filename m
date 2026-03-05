Return-Path: <linux-can+bounces-6943-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IzUBoJ4qWnH8AAAu9opvQ
	(envelope-from <linux-can+bounces-6943-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:35:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B2211C11
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E623301487E
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1F39E6D5;
	Thu,  5 Mar 2026 12:30:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5839C632
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713801; cv=none; b=RCKJlUxjpmg87TbreOrSUUUk8gEifDaDG20CLeKNI+vuhZFnMu+bLZS0Hm94W/xSnou03cvWS6rKYm7OU7jes9JxyjxhJY86LL2BkVowtRQCzm8YT/izdquHJ/Qlug/jjq24y5uGyuZ6T1YZzjM1ygVh/aRaObKgUGrADfqIbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713801; c=relaxed/simple;
	bh=4D2Q39ZrE8YmvazKvKW3aF1/g5Cpv43ee/MaVGKVTBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUh5rzlX8ktIwReC3FqDg6u4PcUSj6zPhtTzp0X1ifp7SXN1W1vQxv73sFaUx0kxlYiHZV7Y/k2v/0rioi1BKas3WFTTkRHfbfDEHpiUwFcGlohVFolDw0f+tXu9W61hvAJXkc9JsQXM5JS2QbFMygvoUoJJngobeIEgL3PwIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso589730a12.0
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 04:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772713799; x=1773318599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrCqdrr01xMGx/SCx6YPhCapPZnumyW3whTx771nk9I=;
        b=sWbD9P6lixvMTGHruukOI5GZgIxI4TP0w2Ps+KxqKz+swNX1pmOvMyROuvsT0pvTSr
         zqcJCR6HBNagraIIiHRvxcPfXpDG7TbEYbWDJrjFGZ1ztvhLITePPfyBgLWq4kSUfWlR
         rHBl5UCEnFbjVKpEd+aExlU6xW3YwhGyBu1lTtGdrY3lpf8M8xm0SLNC15iVaCjMY5gw
         MvVNaze0Z7w1OqrJ3UzSIPB7Dt95+gG24sibHdqHLuq5ovY7OzsFXnrkr0oYSedU1esR
         iuqWsFrwLsOfgTH26GmqoYsYgVgxpRXfz73rbovbuw6YXQq0DJHn+JbuPrYB6YIlbFew
         IggQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa/nHhID42UVP02hAx7UflHnQeQmjzKl5/GNUd4aMD1tTJzKYf907h8yx/O89/cL7g/+EGJNqyHkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LrRyZI1zknTOzg1/1Eu2/KUgD/OKddX+uZ9nSnxnBw42ON6J
	bWuuLzdtn1J7rLwtx+XWjXeVdj9E9Vov3/jIns5vbcuBMkSRs8kW+QF4
X-Gm-Gg: ATEYQzxHWoQ1STDV07vzPl5M8UhbuSH/Aqf1eUlkJKfimCNnjMImIVKnmTsRr92cCvq
	O6xAcNmP/7g0NFUpa96hDnIQor9onyRydZgetS2XdbAiaTM/1ySRfGTkBGNuR9b6ZPwnJpVKsqP
	IsC8NkOND1M1ViGpjJkbi2Z7SH+lWEOQa8AvqNBT5MgQXZAK3tF4Y4oeuoVsrfvpnCwNirA1u3S
	Amjwta41LixQKZDA8N+8SrVLF1g+7gBx9HVyBcRQb1DAftcilEz7hR3AvApCekTaRLzqzZg7BKp
	1T7kC/O/iGkDEFmz9ymmDXnKFsVO3gy67aHhyuCzarQ/PzE88iAfWqqBLcP62xiwa5Axm+Zk3PK
	htEaW2m9T21cTaMjSilW/u3ZG4HNP/6g7LZr8ZvfJdi9YPxr52OL1vm182B0KpPjv9qP3kGroeA
	TBuq86hMVFpM2T7ChKgfijkt00cVDpjOX2SDs9P5EVYLt+gKr+i5oOoGJyjmI0z46EtVy14jq1o
	PnhwZhPEMoq84ifqpcICcMsct13sIwyLzyTJ+p4jY7t4LhZWus=
X-Received: by 2002:a17:903:1a43:b0:2ae:4701:3c31 with SMTP id d9443c01a7336-2ae6a9cc1c0mr59976385ad.11.1772713799017;
        Thu, 05 Mar 2026 04:29:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa43sm225561035ad.46.2026.03.05.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:29:58 -0800 (PST)
Date: Thu, 5 Mar 2026 21:29:57 +0900
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
Message-ID: <20260305122957.GA1652563@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305121532.GA1649635@rocinante>
X-Rspamd-Queue-Id: AB0B2211C11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6943-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 26-03-05 21:15:32, Krzysztof Wilczyński wrote:
> Hello,
> 
> > K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> > K:	\bphy_(?:create|remove)_lookup\b
> > K:	\bphy_(?:get|set)?_drvdata\b
> > K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> > K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> > K:	\bphy_(?:init|exit|power_(?:on|off))\b
> > K:	\bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> > K:	\bphy_(?:reset|configure|validate|calibrate)\b
> > K:	\bphy_notify_(?:connect|disconnect|state)\b
> > K:	(?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> > K:	(?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)
> 
> What about
> 
>   F:	drivers/*/*phy*
> 
> or something along these lines.

For content match, it could also be:

  K:	phy

I believe this would match everything of interest?  Perhaps there is no
need to have any of these complex regular expressions, would be my way of
thinking here.  Makes it easier to maintain, too.

Just thinking out loud, really...

	Krzysztof

