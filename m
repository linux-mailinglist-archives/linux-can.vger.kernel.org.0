Return-Path: <linux-can+bounces-6932-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC/+Fn5PqWk14AAAu9opvQ
	(envelope-from <linux-can+bounces-6932-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 10:40:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436120EB31
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 771173045023
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C893793B1;
	Thu,  5 Mar 2026 09:30:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A6377EDE;
	Thu,  5 Mar 2026 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703057; cv=none; b=g5s6+atBWe8nOh2hBCljcUax4hwrFOEPnT5i4bRH8mxhMceWzrfchtjemLUE9r+eP/YCmPpxnuKX8qgC1lESqKM278tTRsPWiWy1hj2S1dC5BSxuUnBvBYRvf3L6Yk93yxGS+R/sOJ9JJNwsxM0WumC9WmHa9JOR2XpCPEjJGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703057; c=relaxed/simple;
	bh=Ut46HYocLwE7mAygLk4hPfAtQ/G8RDXQPhMmYhMyFec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTndE+PnD1KuGMi550aNsyHVTdzLlw65txK590dYbuoEQ3ThtN+XjJKSkk67mPA+7kDa9v4BPdCdw/EB1sw9+c1tuEKFra2QJunKFdAC5Zeg1a9BbV5bs9N4Ue8f3UWUhxGowNXUIcQArEKVh4JyjZNzPoA1U7ZubIeinzyOHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 6EF351A090A;
	Thu,  5 Mar 2026 09:30:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id ABA5119;
	Thu,  5 Mar 2026 09:30:41 +0000 (UTC)
Message-ID: <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
From: Joe Perches <joe@perches.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Konrad Dybcio
	 <konrad.dybcio@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, 	spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com
Date: Thu, 05 Mar 2026 01:30:40 -0800
In-Reply-To: <20260305085148.7cwo3yflp7vcfldf@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
	 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
	 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
	 <20260305085148.7cwo3yflp7vcfldf@skbuf>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: isin6ba55864u4k7cspzxagise7enff6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+c/QqwBFj4RnbTOHAHP0u/fhPSDrZvfXg=
X-HE-Tag: 1772703041-391055
X-HE-Meta: U2FsdGVkX18CpOmWAsQNq/nzIGrueYMCLFpafncVkMPEeWn8lMHmxGid0nuFShmczpxd7LMIQ2HkJXitNrouaAWweblPom1aNWswKBKkaGGCen5irY0lnX3z9ty7T8amhD6qn9Q5wfYeFrX1AAy/tVHr70RJ5jxHv1CzpDKls395qE7TAifFzgOqcxBZ+LxnR/uVacI/Z8SiG+R8Q0lWc4dUv5BUq0HaFG5uC1dlHaBdlDEn65TIo3X5+7C0AcoUpQeypXp8sK9gp+VHT+vsBW/Ta2vT0Zqxi066+g9opvcn5emNN3z91009RwQ+r7ADwt/gmX2gmKTLfK9kac3enKskM+3ua1Jz
X-Rspamd-Queue-Id: 1436120EB31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[perches.com:mid];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[perches.com];
	TAGGED_FROM(0.00)[bounces-6932-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@perches.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[perches.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 2026-03-05 at 10:51 +0200, Vladimir Oltean wrote:
> On Thu, Mar 05, 2026 at 09:39:35AM +0100, Konrad Dybcio wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 55af015174a5..bdfa47d9c774 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -10713,6 +10713,7 @@ F:    Documentation/devicetree/bindings/phy/
> > >  F:   drivers/phy/
> > >  F:   include/dt-bindings/phy/
> > >  F:   include/linux/phy/
> > > +K:   \b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|o=
ff)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvd=
ata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|stat=
e)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)=
_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\=
.h|phy-props\.h|phy-provider\.h

You could use multiple K: entries instead of this monster.

And please use (?:<foo>) to avoid capture groups too.

