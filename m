Return-Path: <linux-can+bounces-6672-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOkyOgaTpWnXEAYAu9opvQ
	(envelope-from <linux-can+bounces-6672-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:39:18 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1621D9F30
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A734530078BA
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF873C196A;
	Mon,  2 Mar 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AiU3tQb5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE70368287;
	Mon,  2 Mar 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458614; cv=none; b=jjTtwIcbGHqZgwvSjeALbHRoR7puH4TlXyvbaDx2N7A1gaYkeF+RKiuRvk+WCFq7hBBJzS35jSRzDaaS2ZxUHE/kqOiB8kDgCy/zzF0i/43bhSUHW0WqWP3ikCxJOpC5T56Bu0rSXteQulOt+yPZnv+aa9433Kj+l3wyjlP4Iuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458614; c=relaxed/simple;
	bh=pQw2YjOswnnAOk9XprpzqH7dOiriJ4oyqujEFVudZ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESxaDJTi0IzT8jMM3iZjQcaqMM+EkTMdiLbweVdGbOuV8/oaCTb8TofRQBAqLhoJhXNma0bd+2F2kVQ/ddF6QE5n8Dh3g4DbyVLBXKPc7DlDF7cMRISRbU7Mf+G8kFrhuA+yQGskpwJLG0P/dN0nPy0wAUc6nBt8vautgXL5SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AiU3tQb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06D9C19423;
	Mon,  2 Mar 2026 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772458613;
	bh=pQw2YjOswnnAOk9XprpzqH7dOiriJ4oyqujEFVudZ/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiU3tQb50RXvvQu0+eRgc2Irk5aaDrONgCEPc0oJ/ucwWHOcEYmL0pMmlRKxiugaP
	 vLkyi0NrtOTzxbRFlIToL8hzPBqtXnES1XUMoZSgqsULk910A7lUhIxyrnk1rhOo74
	 1PshY/bMd1S19YH+7hU8WZLatcN4936BSrwcCBCQ=
Date: Mon, 2 Mar 2026 08:36:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
	stable <stable@kernel.org>
Subject: Re: checkpatch: format of stable@k.o address (was: Re: [PATCH] can:
 usb: etas_es58x: correctly anchor the urb in the read bulk callback)
Message-ID: <2026030257-tavern-espionage-dbbc@gregkh>
References: <2026022320-poser-stiffly-9d84@gregkh>
 <20260302-festive-crane-of-fortitude-d135bc-mkl@pengutronix.de>
 <2026030234-sheet-countless-fd2f@gregkh>
 <20260302-brainy-scrupulous-vicugna-164ebc-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-brainy-scrupulous-vicugna-164ebc-mkl@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6672-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.430];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 8C1621D9F30
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:11:37PM +0100, Marc Kleine-Budde wrote:
> On 02.03.2026 07:50:58, Greg Kroah-Hartman wrote:
> > On Mon, Mar 02, 2026 at 11:01:48AM +0100, Marc Kleine-Budde wrote:
> > > On 23.02.2026 17:39:20, Greg Kroah-Hartman wrote:
> > > > When submitting an urb, that is using the anchor pattern, it needs to be
> > > > anchored before submitting it otherwise it could be leaked if
> > > > usb_kill_anchored_urbs() is called.  This logic is correctly done
> > > > elsewhere in the driver, except in the read bulk callback so do that
> > > > here also.
> > > >
> > > > Cc: Vincent Mailhol <mailhol@kernel.org>
> > > > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > Cc: stable <stable@kernel.org>
> > >
> > > FYI: checkpatch suggests:
> > > Invalid email format for stable: 'stable <stable@kernel.org>', prefer 'stable@kernel.org'
> >
> > Checkpatch is wrong here, either is just fine.
> 
> That check was introduced by Dwaipayan Ray (Cc'ed) in commit
> fccaebf00e60 ("checkpatch: improve email parsing"), a.k.a.
> v5.11-rc1~133^2~46.

That's some regex hell that I don't want to attempt to fix up, but
really, what I have here is just fine, and "should" be ok by checkpatch
as well.

thanks,

greg k-h

