Return-Path: <linux-can+bounces-3614-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C02ABF448
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC054A79DD
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E5255F2C;
	Wed, 21 May 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eaBmbSR2"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10392231A37;
	Wed, 21 May 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830236; cv=none; b=mumUFwA3rbm4kGxNm7kcbnYLHp6ES77R8745IlDRDcQW4ojbO6b6NA+nGQJs09MwhRVXd1khfDrgF4h5BQTmTe0isBwcjr0w4kRjjvbf4RF3P5L76BnKYUHyqPcwlbk8FxI5bosKHr2mGbcYNFF/sdCWYckYzfeDY+Yi0i77d80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830236; c=relaxed/simple;
	bh=DOJDmTsY7IcPVHChU5j9ew4xNita5TY+w7wzmZGWwxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQHvcoPgCLCKI8hqy2ncWjh0TNCo8Sp9h/jW6l60jfW+7/zbBfDuTSRYmB2oMNpn2XQRH+lNTMgg4l12iqqtvbTe9MkznMocXRkRTqu+gi2DJ7MNElsv+9YRi0fcE7JYWJcMevmQ5rpWYNyHnmk982fNpZobqIEVfT897Ki6zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eaBmbSR2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QC7FOGnDbniB2ILmcErRWoVq08mHS6HymgbS60fVsNI=; b=eaBmbSR2rZbHZEkXbI9dy+v0ls
	nbfSvlVO0pVcDnUPAVF1UnPSmfrjfGCGJ3o4TAN2W2n6LlMP5Ztg7AQIao7W0pG3tDdzVg4ELN+ot
	QR57WcRM8+V95XG0xrRZ4I4OoAY6XVsPDWFTxEs4tMVopcZwHXDblxqIPwGS2El8EsKA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHiTy-00DGcl-0O; Wed, 21 May 2025 14:23:38 +0200
Date: Wed, 21 May 2025 14:23:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] documentation: networking: can: Document
 alloc_candev_mqs()
Message-ID: <e361c02b-fddc-4b80-9ae2-ee3f2b69f69a@lunn.ch>
References: <a679123dfa5a5a421b8ed3e34963835e019099b0.1747820705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a679123dfa5a5a421b8ed3e34963835e019099b0.1747820705.git.geert+renesas@glider.be>

On Wed, May 21, 2025 at 11:51:21AM +0200, Geert Uytterhoeven wrote:
> Since the introduction of alloc_candev_mqs() and friends, there is no
> longer a need to allocate a generic network device and perform explicit
> CAN-specific setup.  Remove the code showing this setup, and document
> alloc_candev_mqs() instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Dunno if this deserves
> Fixes: 39549eef3587f1c1 ("can: CAN Network device driver and Netlink interface")

Documentation often does get added to net and back ported. It is not
going to break anything, and there are developers who work on the last
LTS rather than net-next.

	Andrew

