Return-Path: <linux-can+bounces-1973-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DA9C4FDC
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33713281301
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09C020B7F6;
	Tue, 12 Nov 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="U9zeIuSG"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49520ADC0;
	Tue, 12 Nov 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397445; cv=none; b=Kgp2MOXKeOBaLrnd2IB6MdY1QnSkoPlpfCSkxN+U2eutolzQICdc1MxWn4t6Rzsfw/qCnlNWGtWUuHLlgMnnV1dj6wotBawHgy7+HqwBzjKLoB3OWxcIWQVz7vdf4yePA72HtfXRRI54AdIo0tUY51NIFchXuELuo2wevmxrB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397445; c=relaxed/simple;
	bh=gYK8Sr5oh64mtihPCqd1kqaMIT1tBWPjHL4NQqEPAb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGY/pby93wG0+ENTMSkJKXjdREJhDoEEoUgbPg+swiyg69+mLh4jnLcYlvSDUOuSw3OXo0vIrkXtEdkr74Pmki/rzcj9c77rWG/LvXh2jzwCElo5M+PXkYyEEltX8Bw2aI8FcsfJYVpzQt3ul5uLBS3FwvRfn6nah+SuB+eP3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=U9zeIuSG; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=AsWwEEvmw/bdBxEEFaD+tDkgRMXNBIOX6N+pznhzV4k=; b=U9zeIu
	SGrGXjoQErw2vKerYTqZX06+8gI5WNy1r/v8gY34qXPX/JWYfUwnLiGnC8rPSM7JOW0bPgqNqTWhQ
	3zPwMMztceWhILwN2makGTOK6iFTQa/ualdVj7eOtyFK4KbKSrqa0CWb2f5DRMNcqgm2E4SsWLCNS
	gR+wdLYlfwVYZEtB9vKUcEfFz+S5NBYSWXqAT9GPTQKUA2iDU54KN881gNUsxbt7XdxCojJDYdXYc
	v6gVhqCuVeKp2IJ3wQI6RbAbBn+e9o2TL2H1N2dbcx19Zs+OaAOa+P7KLUKPC3vewxztQb3Fp9e63
	X6fQ+AZHNU/NFGIOhvV1z5Zp7x2g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAlZB-0003Cs-DP; Tue, 12 Nov 2024 08:44:01 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAlZA-000PqT-2H;
	Tue, 12 Nov 2024 08:44:00 +0100
Date: Tue, 12 Nov 2024 08:44:00 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <lfgpif7zqwr3ojopcnxmktdhfpeui5yjrxp5dbzhlz7h3ewhle@3lbg553ujfgq>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241112-bizarre-cuttlefish-of-excellence-ff4e83-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112-bizarre-cuttlefish-of-excellence-ff4e83-mkl@pengutronix.de>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27455/Mon Nov 11 10:58:33 2024)

Hi Marc,

On Tue, Nov 12, 2024 at 08:38:26AM +0100, Marc Kleine-Budde wrote:
> On 11.11.2024 09:54:48, Sean Nyekjaer wrote:
> > This series adds support for setting the nWKRQ voltage.
> 
> IIRC the yaml change should be made before the driver change. Please
> make the yaml changes the 1st patch in the series.
> 
> Marc
> 

I know, so I have added, prerequisite-change-id as pr the b4 manual.

/Sean

