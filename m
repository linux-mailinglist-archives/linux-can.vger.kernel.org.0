Return-Path: <linux-can+bounces-2975-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFAAA498BD
	for <lists+linux-can@lfdr.de>; Fri, 28 Feb 2025 13:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D6C1898423
	for <lists+linux-can@lfdr.de>; Fri, 28 Feb 2025 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D548526039C;
	Fri, 28 Feb 2025 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b="EKa9ezo0"
X-Original-To: linux-can@vger.kernel.org
Received: from outgoing1.jnb.host-h.net (outgoing1.jnb.host-h.net [129.232.250.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7925DD1F
	for <linux-can@vger.kernel.org>; Fri, 28 Feb 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.232.250.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744332; cv=none; b=GkrOogP63VSFw+tM6irVgnOYoz6SNMBQU5ulVOXQsWKKaNlxadpXhtECBqAahJvdS2wfmxziFwg2o1IDez9Cax0jj1WWyS1k6zkcZWadURfQvHIXvIffW1V16atq0PTTMOMBiv05A5wq62L2fVDAMWTXW+p8+4bblvmkAcl6GkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744332; c=relaxed/simple;
	bh=LnJAb5OtSiiPPpVmdSEicOxdfy335XXtHun9Lv2d8Bw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tT9wbhLWmYm4gpSLxaO1uB982C9JJnuOe68w/ak2K85JvwmUfoyG766xEo5+CdcJ9eUT/BRZM8Q3hko2y1Pp39m7LNEpjUzL3Erxw1C5RFrqJ6Th2oqng9JE2PVuKB+g/8WpIbv2VCyt4N7qkiT0aTs1Yvk0os2L2GFQxf7SCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za; spf=fail smtp.mailfrom=coldcon.co.za; dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b=EKa9ezo0; arc=none smtp.client-ip=129.232.250.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=coldcon.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=coldcon.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=t+qwmUT3iOAm1DfPM+nbVN5TXLHXkSwi3Xte37fm8Y0=; b=EK
	a9ezo0n0+0UkNDsCrn/9TWF19FOarO0BZhWLOC30aAcnGILyxcETmUjfkcgxxFgCrXRHX0+OeYLIS
	pbUpUK62PREOwVw9vEuvAE95N0ON/AF8TRvuxKi5iVRjl7VK/Qf/fjkxnzi9ivI8gOgj3Na6lMcAk
	7Yz42EjFXhnYICwX0a9tHQt5Sqx1HfjLe3eoRq4oMe2t6yuqBFovZ26AlstRZuunSTVnA1YdVuC+Q
	phdOSeNgfsUsqexztBlgOTrUNaILGoAUDelhvoFHz4vCb1wpA/Ry7G3p2+CQB6SRSS4/j2b0W0J/l
	qf79rWQtYHz+DhVBP+NKBEuoKsWi6C9g==;
Received: from dedi166.jnb2.host-h.net ([41.203.16.166])
	by antispam2-jnb1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnz7O-004BmR-H1
	for linux-can@vger.kernel.org; Fri, 28 Feb 2025 14:05:28 +0200
Received: from [104.192.5.240] (helo=coldcon.co.za)
	by dedi166.jnb2.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnz7N-00000006UrF-2gAd
	for linux-can@vger.kernel.org;
	Fri, 28 Feb 2025 14:05:26 +0200
Reply-To: funding@investorstrustco.net
From: Iyke Nikolas <avaril@coldcon.co.za>
To: linux-can@vger.kernel.org
Subject: Re: The Business Loan/financing.
Date: 28 Feb 2025 12:05:24 +0000
Message-ID: <20250228112431.E48AAF5C48825F1E@coldcon.co.za>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: avaril@coldcon.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: coldcon.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@coldcon.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.88)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+CzanhUpQxxY0jGcn2Rs0cPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zd0RYYehWb63bIipkP4BQ4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8sq3xHGjwY23W/fr1qIdwR0ceb4o0/MLsfRXq2B6Bj1eqIhJNeUYrwmMRp0o
 fTv2z6OWrRCR/TGJ+LxBEbBCS4VQbvH/y4TBKwDHfQa0wCenXC+SjAMhlxVTUP8RXDYi0U1JpmI0
 71bWBu5BNTe7wFyCRVEbXfJnI+gG5QvGXTtovK7VZqJmzCeHtqZ+QtMgTB0iLwRMaKsK8lAeAhb+
 aZDwTMQ3Kg3hL2oXz5A5E5R/dS4GkJ5hfB+qWugfDEytZYoACfRtBjLzEjgIZNLWhI/Mb7SOSczA
 6/BlLHspgKwfxkpFBMGtk0DHIsZm7eDIdidx3dBtceKX2dWiEm+7oHm9xBEeGmns8QeFADnQDTrf
 rq/iPB9nbD8ib8/LRKDL9uX6nH0SFAAL0wIn8kjcTporPPrEMEUywY28JQK/4tt3rRkgoL0bckEu
 e7jwJnlVscnY5Qx4fJOk03R5fJtf/Dv/9m9+uP0zyEETyQahh1k9u6fK30DS261NPJJTtvuBG/wS
 fPVkeRJRF5+7mPhPAjSIkSurkPtKU6NZBHIBNV3afsncGKvizexX1SLE8awz2UolS9YoHFltGqun
 dRd2vfQDxRcLZivEDcmpAbM9ZRc0AilfB1kGL3fSE2MONRlXMKtuCu4G2nFtWAVIvsCOu5FM/fu3
 x7erbsjFB4F58vtkzSP0sF/4XcLr6h0iHj2MGQEPT2ZGSha8Rb9KaRMF7EPjaeNzMeYMM/qc9He6
 zd8kb2nrAUZxhra3hcJgPbkQnKk3ClTXlSfQV8rvfnHgqk4U1Gt/9ppEoh7u4mXKDwivYDdQSwbI
 5IDQMARnZ2/ixmby7m9xwLahPGY0/PEbdICFRgFnzGg9rgSSO4p0kGP/3qk3UfKQ9OIEeAN+Uhcn
 OZzPia/e3RTzWtZ565WlxfE2
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

Do you require capital financing or low interest loans to advance=20
your business projects or growth strategy? We can provide with=20
the needed investments for your business. 

Get back to me if interested?

Best regards,


Iyke Nikolas
Managing Partner
Investors Trust

