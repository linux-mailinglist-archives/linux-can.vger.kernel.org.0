Return-Path: <linux-can+bounces-8-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC17E59ED
	for <lists+linux-can@lfdr.de>; Wed,  8 Nov 2023 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0272B28140B
	for <lists+linux-can@lfdr.de>; Wed,  8 Nov 2023 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1B3033C;
	Wed,  8 Nov 2023 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7Z5lHbG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4D3033A;
	Wed,  8 Nov 2023 15:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECEFC433C9;
	Wed,  8 Nov 2023 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699456994;
	bh=GYkmk8qCTCeJLO8tC4gkRcDTmGCJ6Fq6YovqQyNeMc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7Z5lHbGCP/2ulRL1hIUMwtIwLwQLo426JNTActtX+dc2/GhkZkUMYZfVli+LRf/i
	 4O3RAcTPZtKBHHPXaH4CqHeuufwE9kAmmGkGRRuy7GHZfZ1icIjYEwVkqnTvGJ0GbT
	 B/zoymBCtjuKGcu5TeTLuEEtpr8jj2UvHSoqEmxBPKYZvzl2zeqouvs6q8rxAd+WnH
	 BPgFcecgSeez7WNBNfcUEn1wlZhuoYZFwGKntv120VOI8y8CVgRGoFEUY9i0Lo7BJl
	 XGWKjB0K/iPP0liiDJSoyu7UXaxP9IZRj7p2qsXAc9c8sGWvLiSn1Zg59K4A5mpO+L
	 4aQ2SNI9gV4zw==
Date: Wed, 8 Nov 2023 10:23:11 -0500
From: Simon Horman <horms@kernel.org>
To: Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v8 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
Message-ID: <20231108152311.GD173253@kernel.org>
References: <20231025141635.1459606-1-stefan.maetje@esd.eu>
 <20231025141635.1459606-3-stefan.maetje@esd.eu>
 <20231103164839.GA714036@kernel.org>
 <1a1d0f4257cd980c58b6e2f83e2456dde5fe9441.camel@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a1d0f4257cd980c58b6e2f83e2456dde5fe9441.camel@esd.eu>

On Tue, Nov 07, 2023 at 01:27:34PM +0000, Stefan Mätje wrote:
> Am Freitag, dem 03.11.2023 um 16:48 +0000 schrieb Simon Horman:
> > On Wed, Oct 25, 2023 at 04:16:35PM +0200, Stefan Mätje wrote:
> > > This patch adds support for the PCI based PCIe/402 CAN interface family
> > > from esd GmbH that is available with various form factors
> > > (https://esd.eu/en/products/402-series-can-interfaces).
> > > 
> > > All boards utilize a FPGA based CAN controller solution developed
> > > by esd (esdACC). For more information on the esdACC see
> > > https://esd.eu/en/products/esdacc.
> > > 
> > > This driver detects all available CAN interface board variants of
> > > the family but atm. operates the CAN-FD capable devices in
> > > Classic-CAN mode only! A later patch will introduce the CAN-FD
> > > functionality in this driver.
> > > 
> > > Co-developed-by: Thomas Körper <thomas.koerper@esd.eu>
> > > Signed-off-by: Thomas Körper <thomas.koerper@esd.eu>
> > > Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
> > 
> > ...
> > 
> > > +static int pci402_probe(struct pci_dev *pdev, const struct pci_device_id
> > > *ent)
> > > +{
> > > +       struct pci402_card *card = NULL;
> > > +       int err;
> > > +
> > > +       err = pci_enable_device(pdev);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
> > > +       if (!card)
> > 
> > Hi Thomas and Stefan,
> > 
> > If this condition is met then the function will return err,
> > but err is set to 0. Perhaps it should be set to an error value here?
> > 
> > Flagged by Smatch.
> 
> Hi Simon,
> 
> thank you for reviewing this. Looking at the code it is apparently wrong.
> 
> I was not aware of smatch. I got a copy and could reproduce the error report.
> This will add another tool of static code analysis to my release routine.
> 
> An upgraded patch with a fix will follow.

Thanks Stefan, that sounds good to me on both counts.

...

