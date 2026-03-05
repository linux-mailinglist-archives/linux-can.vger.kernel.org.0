Return-Path: <linux-can+bounces-6955-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OglFf6kqWl5BQEAu9opvQ
	(envelope-from <linux-can+bounces-6955-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 16:45:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1D214C42
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B4F83017FB0
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E63BFE29;
	Thu,  5 Mar 2026 15:36:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113B3A63F4;
	Thu,  5 Mar 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724967; cv=none; b=ko9mG0d23pCHLOp8T0zGjA0BbG+BR4PaODhM+IC14fLD4z3EQ4/DRoqIyVkO+312BZxnn8qZf4cZRz8O9d+fVwnGMsc4ajLTCSTff0TcfCYSfDjhA7dmUHmgoVKkGK7/pPiX3s5ltzTRnGFjhH1TzWXx+X/ddEucRJeCKOEGHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724967; c=relaxed/simple;
	bh=qocaInGB0SlfrWm+uA1O3uhdYbYezjAl8jrEXMJzGhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWEfGZx3KKfqPR+EulOrLmlCpf/Zbe4FGWLQ38ONHzUkaONzLXL9e6My5PMks7NIArs4AmwsgoWqVrWV9nAjhuWpGrpWu7nVy9K1IDrlnpbbsxe+dAudTWfhENgZOVcfAVbKtdizgBtl3sxPU3CRhJwgBJmfJiRbqPuMFpyAKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 9322C14014F;
	Thu,  5 Mar 2026 15:36:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id E35031C;
	Thu,  5 Mar 2026 15:35:55 +0000 (UTC)
Message-ID: <21e84301a7c37f9d5ce6f0ddcaed7846174d2a4d.camel@perches.com>
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
From: Joe Perches <joe@perches.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, Neil
 Armstrong	 <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
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
Date: Thu, 05 Mar 2026 07:35:54 -0800
In-Reply-To: <20260305114352.2f7btqixg4tu5bzl@skbuf>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
	 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
	 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
	 <20260305085148.7cwo3yflp7vcfldf@skbuf>
	 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
	 <20260305114352.2f7btqixg4tu5bzl@skbuf>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: hdghxtayq5bkfzsomxmnfbydyyebzipf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19f3I+nQL7Hl0m6eSD18a/IIsXK9f3qkJo=
X-HE-Tag: 1772724955-671908
X-HE-Meta: U2FsdGVkX1/X7uxRzGLN+IX8WCZcO8p7ZTfkKmYNWBtz0ybputMaHEYE9yjxoGJ588aNvqlmxPrL8260emaV8dmXUI0e+INEtvEJY25I/Ej/PwqlxILke5yF3tqaj6xtvov8nI2F5oYM0uwbLv+6+skyh/sdJqBRUfJJKxLUzixxjwVPNZYZfPXpcC3lGcz5BMW1nsCCc9lzUvpFfMAODgtiRdX4Al8waTK8ABKVHmTqbt8uPB5EPbopscO3f/XucT2DdozpyI3LxZQRIQw7tIxAWEpzWgj98RYMI3rQa9CVBr40+v4Qte7+qYx1OCa5
X-Rspamd-Queue-Id: 0DE1D214C42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[perches.com:mid];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[perches.com];
	TAGGED_FROM(0.00)[bounces-6955-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@perches.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[perches.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 2026-03-05 at 13:43 +0200, Vladimir Oltean wrote:

> K:	(?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b

You have (?:...)?phy(?:...)?\b

I rather doubt you want anything that ends in phy

That matches words like cryptography and way too many dts/yaml files

