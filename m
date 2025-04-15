Return-Path: <linux-can+bounces-3398-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B77AA8906F
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 02:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C151899BD5
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A9133987;
	Tue, 15 Apr 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTZMzOQA"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCB22EE5;
	Tue, 15 Apr 2025 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676833; cv=none; b=iC4d2z8uf9jYwNeZSX+MwRCw4WwJKuahvKAesrgP3VMqGEn9cX1bNrxSp+81+WXCVNObvS4tu3v3YjVxMMQrFFbO8XHcBxj00nDcX2tbkOg88JMWS/ytuRQaTTod/FB0X1wiaVBTryTu3DuMpAB49Dy2Ju16Ul6mNTCsnttmHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676833; c=relaxed/simple;
	bh=p/7BiZ9Yzsgk30h25OyaW/iYOh0nxPPaqAteJXbR6bY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=T9v+rFCzMcGPzxjNuAnzEDr6PzE2nybIe+CnTYGF/FSYVhBqkfa6nOBvvN2VODSP3HDCXxwiB+jNRy2J1HHj4Rdm3cGejqAYW0OL4SIKBOmLYqbr+4T7/lFoNrO/40yCzttrZhZRp0MUSEAwP2pxeUlotXwbslPHNT6CpAFCkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTZMzOQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA4C4AF09;
	Tue, 15 Apr 2025 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744676832;
	bh=p/7BiZ9Yzsgk30h25OyaW/iYOh0nxPPaqAteJXbR6bY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XTZMzOQAUI7mP2pfZTh93/xCW2LAIw3Q1mVUiaCy1BhVWLOn7WSu5NH19L7r5VSBU
	 PGMACMxYH1rmDBIDPfv3pb4Y5BwTMYgot2rvR+Uae+E5rSy22siZAM+ReHSOsLwrjI
	 5xfd7VCx5k2LqLChVTk9fKRlgIHBoqBEKwl+8YBHYQfHe6VXg8Ihlqc+/zDqfLrzEm
	 W4H/mFFq83PFZuXrIJhtPG6sWVSjc3UzoEuFhnEdrEA6z+cuwzDhmdV/qYzput4CkL
	 yIRQnHaGVhMUoHiRM/HCZWfcE/NHz82GL2XJJz5wDh1cQcLwWHcuBo7kJ0xfyr8Y1j
	 0K0ZOek4vO4Hw==
Message-ID: <e4bd8e47aeab761e409121ac9bc19408@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250414-camouflaged-silver-dodo-d0c000-mkl@pengutronix.de>
References: <20250414073646.1473157-1-ciprianmarian.costea@oss.nxp.com> <20250414-camouflaged-silver-dodo-d0c000-mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: enable PER clock before obtaining its rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, kernel@pengutronix.de
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Maxime Ripard <mripard@kernel.org>
Date: Mon, 14 Apr 2025 17:27:10 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Marc Kleine-Budde (2025-04-14 02:55:34)
> On 14.04.2025 10:36:46, Ciprian Costea wrote:
> > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> >=20
> > The FlexCan driver assumes that the frequency of the 'per' clock can be
> > obtained even on disabled clocks, which is not always true.
> >=20
> > According to 'clk_get_rate' documentation, it is only valid once the cl=
ock
> > source has been enabled.
>=20
> In commit bde8870cd8c3 ("clk: Clarify clk_get_rate() expectations")
> Maxime Ripard changed the documentation of the of the function in clk.c
> to say it's allowed. However clk.h states "This is only valid once the
> clock source has been enabled.".
>=20
> I've added the common clock maintainers to Cc.
>=20
> Which documentation is correct? Is the clk.h correct for archs not using
> the common clock framework?
>=20

I don't know what arches not using the common clk framework (CCF) do so
I can't comment there. If you want something to work on an architecture
that doesn't use the CCF then follow the header file, but in all
practical cases _some_ rate will be returned from clk_get_rate() and
we're not going to BUG_ON() or crash the system in the CCF
implementation for this case. Enabling the clk is good hygiene though,
so is it really a problem to enable it here?

