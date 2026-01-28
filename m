Return-Path: <linux-can+bounces-6319-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PPuAIRqeWmPwwEAu9opvQ
	(envelope-from <linux-can+bounces-6319-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 02:46:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816189C078
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 02:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0FEF3014C3E
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455B26C3BE;
	Wed, 28 Jan 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQC12YA5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45F26A0C7;
	Wed, 28 Jan 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564751; cv=none; b=sdH3m1x3e9i3Vso6D/0HYtrg59M2e7fiaeFokJpQURZs7wKmdlfuSpmI99Xfe0TH6BSlNEqpxHKiAT+d+Pr7Gzd+g/+CG9V/jjml/g53bJ96aq6Jfs/JzUNagW/AfV3KgFBZulDnO8VPzyQ8JEuNBi3XwWNFmJArp1Q4qkcwlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564751; c=relaxed/simple;
	bh=xR+nCpcEPAvk6bWssiF6Fy1/tjjB2CJvOgiP7wrT4qE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVbv0eHT+FrtecxZJ6S1BLh6CWeL5iVnTV3wtgdJBENdLAwcy68bnxFuDl5tUkX/wwYXx6AwF1njma0Lvdc3eNghEs0p7pnUDc7dh1lDlQEqw9MZLJuXvwte7W9boxeZ+1rGDq8usBrVMq0VSt4xAUudJxw8cr5TkAV+OOtO2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQC12YA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C9CC116C6;
	Wed, 28 Jan 2026 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769564751;
	bh=xR+nCpcEPAvk6bWssiF6Fy1/tjjB2CJvOgiP7wrT4qE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQC12YA5Ly93uFkRqStHOwjNb8/abxTAukavgCkDToSJDXSkN2zlmEcf3i/+YcqrN
	 zfXsq62zKzv4es0rsWYkAr06q/RoVVw53koKdOdw4xu5Ju93k3xazRFLPaCqIFdnt8
	 8CpY0kak+YDvChkJZMz7SAhd1suR+j0vF81iuXXtMSeNdsBDRvk9+1o8nzovAfR2yZ
	 ywRxx7v6pYJV2bysWAnyS6r+tdqu1eXDztItju/dkl8ujipnuThkn/hqx/ITgKNK+Q
	 vAGJw7fAiM54+ucjB6miFCBrPeXJSi2Fsc2RM0Hk1UWkEsHHV62Vydjv68OzX1APAR
	 I5WcjmIp1M2Fg==
Date: Tue, 27 Jan 2026 17:45:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [net-next 1/6] can: use skb hash instead of private variable in
 headroom
Message-ID: <20260127174550.5913464f@kernel.org>
In-Reply-To: <20260125201601.5018-2-socketcan@hartkopp.net>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
	<20260125201601.5018-2-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6319-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 816189C078
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 21:15:56 +0100 Oliver Hartkopp wrote:
>  struct uniqframe {
>  	const struct sk_buff *skb;
> -	int skbcnt;
> +	__u32 hash;
>  	unsigned int join_rx_count;
>  };

u32, __ types are for uAPI

