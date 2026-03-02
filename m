Return-Path: <linux-can+bounces-6666-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePoTH0uJpWmWDQYAu9opvQ
	(envelope-from <linux-can+bounces-6666-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:57:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A057E1D94A5
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746E830774D3
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFF93161BA;
	Mon,  2 Mar 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5PRvSFE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93D175A8E;
	Mon,  2 Mar 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455814; cv=none; b=AixSNY3CI0U1QO3GlALBl5b1d5fHQYB0JG20cX/jtdS7OPsiG3vpH2MUS4Ub53SvW7Dyh0g9MAZLWmFtDsVXv2QUGqNyi9p/5CUoBZLkDdUw028D34fDRjeWnwtN73y/lH00DEk7iAWAC/vWIRyWzCep55YBGcuJ+VQComr/Wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455814; c=relaxed/simple;
	bh=7qf6Xy3WgPlPaneNpVblO/sMNQ4rFjeGxi2RGX6hBG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBhnjQ5cgzjpmg5q10c8nB9DogmeU/J8NPw9z07Tez8i1PQ1r8gySlsmtTnvw1rZbW8NmGAnQwdxKHYFlv2sB0aM7hnv8tzJ5pawS4m2FoDNhrSXlaSkQfJzWkGn4VL6FyGeRLHvF7hENxkA8Gp6BXw4+Cf47TVM5k+J1P0F6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5PRvSFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD88FC19423;
	Mon,  2 Mar 2026 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772455814;
	bh=7qf6Xy3WgPlPaneNpVblO/sMNQ4rFjeGxi2RGX6hBG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5PRvSFEySkzPtuikF8fQww72IJfKHJOp8aU7xugixS7EM8SoaLVUZcOqBTCBxUq7
	 UjOQeRB4LARfteG9rU4YNIZv48qMgsWTQ3rmyQKKy623SmnkLRDhoTHAfwAQ+iStm+
	 hlOf3wxQhZDC/re1iYk8cfq9TEx9n6OHx0B7LubM=
Date: Mon, 2 Mar 2026 07:50:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the
 proper length of a message
Message-ID: <2026030244-escapade-visible-2c37@gregkh>
References: <2026022316-answering-strainer-a5db@gregkh>
 <20260302-nebulous-zebu-of-health-688c00-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-nebulous-zebu-of-health-688c00-mkl@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6666-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.382];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,pengutronix.de:email]
X-Rspamd-Queue-Id: A057E1D94A5
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:06:34AM +0100, Marc Kleine-Budde wrote:
> On 23.02.2026 17:51:17, Greg Kroah-Hartman wrote:
> > When looking at the data in a USB urb, the actual_length is the size of
> > the buffer passed to the driver, not the transfer_buffer_length which is
> > set by the driver as the max size of the buffer.
> >
> > When parsing the messages in ems_usb_read_bulk_callback() properly check
> > the size both at the beginning of parsing the message to make sure it is
> > big enough for the expected structure, and at the end of the message to
> > make sure we don't overflow past the end of the buffer for the next
> > message.
> >
> > Cc: Vincent Mailhol <mailhol@kernel.org>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Applied to linux-can, with preferred stable format.

What is your "preferred stable format"?

