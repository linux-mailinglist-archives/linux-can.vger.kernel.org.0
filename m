Return-Path: <linux-can+bounces-7963-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ivlrCY9zRmpQVQsAu9opvQ
	(envelope-from <linux-can+bounces-7963-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:19:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819446F8D00
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:19:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yaCzakvI;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7963-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7963-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629813038F7A
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1194CA28B;
	Thu,  2 Jul 2026 14:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AED4CA264;
	Thu,  2 Jul 2026 14:13:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001642; cv=none; b=sNyM3bc7n6souV9blghRJYUehvFjViU8k8vUEV1yTobTF8Or6lk5gK2qUnnxEcL3neiyq1w115HV12K+XxghB/b5OQtbpzDnCuCBT9V7e2CRXIcLw5ZsIZYOGiEb+lF4O1PiQx/YvlPqB3OyEt52UFWqnHSQnA+58FKZ5eJoQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001642; c=relaxed/simple;
	bh=R98QZzYpDR41aXFD47w3kHfUzVNIU5IUGG2s/zcV2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovgUKMegcYSoxWNA+n+rewnIk0iKwEdlBohw4LWTVjSg5bIro99fV+ZPWr5xrGG6rEeyUqFZD3aNffyOH9TZ6MfcwGWI+qrC3gX2tiiwkykqxE6zDYO1H7AdipfovFVD85vJyeaoslFax0ZVSGXrqoYUVn8rcP/a7ouY77ozONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaCzakvI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCDB1F000E9;
	Thu,  2 Jul 2026 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001632;
	bh=22NrB53quUcL92USbBtWlF+xpexlIHtl2vYI1OOtmKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yaCzakvI2ONHSQhFmcWi+I3WBUkfJSvEKMpe6DJ5uj8d45bflUf/FCSZVKjGlq6T9
	 zHEc+fukuaOhNBr6ZSk/G0hvYQuZQ19gOpx1j8sSuI8OsVy0sBsQ88zOjp2CnNUvDt
	 44CAMBARDqaXB82rV1ZP1CjWaI7fmif+nnrtZeQA=
Date: Thu, 2 Jul 2026 16:14:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: add missing ns_capable check for peer netns
Message-ID: <2026070244-trustable-cresting-2d80@gregkh>
References: <20260617-sprain-dye-86c242ac@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-sprain-dye-86c242ac@mheyne-amazon>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mheyne@amazon.de,m:stable@vger.kernel.org,m:wg@grandegger.com,m:mkl@pengutronix.de,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ebiederm@aristanetworks.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7963-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 819446F8D00

On Wed, Jun 17, 2026 at 08:26:39AM +0000, Maximilian Heyne wrote:
> The upstream commit 7b735ef81286 ("rtnetlink: add missing
> netlink_ns_capable() check for peer netns") doesn't apply on older
> stable kernels due to refactoring. Therefore, this patch is an attempt
> to implement the same capability check just directly in the respective
> interface types.

Why not just take the upstream commits instead?  That's simpler over
time than a one-off patch.

thanks,

greg k-h

