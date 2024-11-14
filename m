Return-Path: <linux-can+bounces-2043-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8409C863A
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C942B2A34F
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72241F708C;
	Thu, 14 Nov 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bGiKHI0O"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55241D1724;
	Thu, 14 Nov 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576405; cv=none; b=qvy8VU82SkZSNwciInkIbwt1HYgrJCYZBtF7E6Z0EwXU4SGE6wy3xT/b8tHAh3e193BJX7m8xJEcrJtOKuUzCvts86jM8ML+OwyuwCzPXQ2P4qbxdLYukcmHsmIgz0+zbPhEoylKWmzTdoEMVtB//KLdilHuvp8bHr9CiNBcNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576405; c=relaxed/simple;
	bh=F4fZ3VEB3sSqhtren7bVKSiH5jDCYsNJ9th8u2b4tcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raDpXxxBQE0udT0cCyI2l0XqiRHVGMyjRMNzgTiTXUASUbd6MKQz0xQC64NFSjY32TXiKFXkN/r+4vRN2cv0BIFb4kBXDxVrPCCdUtPAef0P2RZK3d/WyVyqknOVdRRrupVagga3SHR19C0IBlfEzMkoL5rtcCN4McVrSrI0zQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bGiKHI0O; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=A2KgOI+lSZ0QofXCJ/ce/kUbrulJLZ9zrxCHSMmyqvU=; b=bGiKHI
	0OuvikDXkOLwjVhAmE/u2kIq5YxZjJX4WJVV8GEP3bZmo7/rVYJsL+CtQ44jHmrQmhM57uolrM1Al
	lRLCIN5FqliVY+ybCnmR79Ak/c/jEcVRPKRtR5DF40IFl48Ko2DK93P3QxRUzF7g+fpsCwcdnRKDc
	eWObYAvptZdNnQzezKs2orM3MnfMDbDkfSx0wXIXdXNqggnYe6mNahPmtNqcmQufSgN5dXPTArJjJ
	T7KJUSgvhjfYsPCqpHnQNdXj4aZfQ41Gv7pRzYxaCp1yMYsr0WRpy793H9Q03p/7Th7DTB3VPsGyj
	2SubYZnlSLi9gP+ZxGahB5PghDyA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBW7c-000JqL-LF; Thu, 14 Nov 2024 10:26:40 +0100
Received: from [2a06:4004:10df:0:6905:2e05:f1e4:316f] (helo=Seans-MacBook-Pro.local)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBW7b-0004zD-38;
	Thu, 14 Nov 2024 10:26:40 +0100
Date: Thu, 14 Nov 2024 10:26:39 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v4 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <nza33yftfuzjdf5fkxwwkfqink4xen7hcfnf5chcn3tmy3qnuu@xqcmqvkdfxs3>
References: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
 <20241114-tcan-wkrqv-v4-2-f22589d67fb1@geanix.com>
 <20241114-classy-mongoose-of-philosophy-e9dbca-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114-classy-mongoose-of-philosophy-e9dbca-mkl@pengutronix.de>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

On Thu, Nov 14, 2024 at 10:19:00AM +0100, Marc Kleine-Budde wrote:
> On 14.11.2024 09:52:22, Sean Nyekjaer wrote:
> > The nWKRQ pin supports an output voltage of either the internal reference
> > voltage (3.6V) or the reference voltage of
> > the digital interface 0-6V (VIO).
> > Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> > 
> > If this property is omitted the reset default, the internal reference
> > voltage, is used.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> I've given my R-b to 1/2 not 2/2 :)
> 
> Have you manually added the R-b? "b4" has an support to collect the
> trailers and add the to the patches with "b4 trailers -u".
> 
> With this change, let b4 add by R-b:
> 
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> regards,
> Marc
> 

Oh, I see my bad :) 

Actually just went thru the b4 manual and didn't see that option.

Ran the "b4 trailers -u", It added the Acked-by: in
https://lore.kernel.org/all/20241114-quirky-aquamarine-junglefowl-408784-mkl@pengutronix.de/

Thanks.
/Sean

