Return-Path: <linux-can+bounces-4022-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DDB0D206
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A307541EB7
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 06:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6F2BE7C3;
	Tue, 22 Jul 2025 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="iq4ehCmI";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="tY4Cle+4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498B28B3EC;
	Tue, 22 Jul 2025 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166774; cv=none; b=GGzX1g0b9/w5AgUCvdZORk14HBMIfZxsoCH9nUSYwWit3/am2C9eW95VCbddq1iODel3t3BcBs89MGXurmB1OuR8W/wYQgIJso1Mq2V2g+a9CItD0O/Hi4dJpfsQd9J5BuTPCX4NHfMaDRqYZIRXgtLpqgeSIDfRtDBVgdTaoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166774; c=relaxed/simple;
	bh=CyXxu7mUoRZQLoid+0MsPT7yCQ59e79uXXxErizaq84=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=j0zt5f36qWoMoHK0IM4wj8a4LNLg/2B/PBhlOOxYhu2HIevh6sD6bN35JgyL+W4YO4QyBx7/1W+f84S5Vz4M2J7bAQjmjNZvynvAXM3YHvDHSWJZudYpdrwP0JPJCWGuiKm5AYZxpyakNlYeKPwEN7QtDzstrKxh6D6ZMAR5zH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=iq4ehCmI; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=tY4Cle+4; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1753166241;
	bh=iGhQM/xOdS8eBLkVK5DwQqF3cJfJDt4wZF+v20+NRH0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=iq4ehCmICCrhxK73R9bojyb990CHXLxKTZ/OGfCTDl9iLV1ME+52/MKML7smVClsV
	 Z6EffTD/RS5u1l5XpobTE7W3fN82A0jgw+SU16tkdG5Z+BLiMO975NrQOXiXkr36v2
	 5TA8/osQCbUSfagdc15hhuIjD+J11vS5ue23UxcOIA1hWGSdGZDMFOu5bWikygBQTS
	 ceyosTKvJxDeLqJkZD1fbFggygVMZiODIgrf5DYIfXhxSEfY0OasUFwU8pfqz1dep7
	 T/iJA3FTL2/RCtkeg8BNkIY8mRfcituufRLpobOpGOrPlf8A7cRPBQIsb7GL1kIhkR
	 6ZBg63fB4uPsg==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id BDDE52E48F;
	Tue, 22 Jul 2025 08:37:21 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id BBC7D48D60;
	Tue, 22 Jul 2025 08:37:21 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id GRIWBS1sA272; Tue, 22 Jul 2025 08:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1753166237;
	bh=iGhQM/xOdS8eBLkVK5DwQqF3cJfJDt4wZF+v20+NRH0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=tY4Cle+4Cvxr3p0aHFf+2Gf29UZzjEC4djqEaGb55jUSK4v3A8XNNTHBK4L3hYPFa
	 /dX1WhZGymSwgDIxTqomscQWoAsT434vlEWx4IThKs0QV+pkImchOWLzp5wBwuH/cu
	 9HYLJDrSny0IPU+0c3W1wM23Ke2BOWz92JpIQExraIL/nsapFrmP75k77C8bvJ4Apu
	 ABZy9j0B37sriLLFBvmUbDdxeDMy2PMN0BSboD9omO5aAtxRYOZR1f5y8PcaAXezmf
	 SrDNp2mwPV6lVn5003bUa/5bqrFn9/kApU7aozL3noQQ1LuAA/aMLlMdzWI/0dvXPP
	 qLZ1SkvLuVV/w==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id DAD9A4900B;
	Tue, 22 Jul 2025 08:37:15 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
Date: Tue, 22 Jul 2025 08:37:23 +0200
User-Agent: KMail/1.9.10
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ondrej Ille <ondrej.ille@gmail.com>,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Marc Kleine-Budde" <mkl@pengutronix.de>
References: <20250722035352.21807-1-luis.hernandez093@gmail.com> <b694009f-72eb-4eb9-85b1-db19d93593e0@wanadoo.fr>
In-Reply-To: <b694009f-72eb-4eb9-85b1-db19d93593e0@wanadoo.fr>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202507220837.23333.pisa@fel.cvut.cz>

On Tuesday 22 of July 2025 06:06:30 Vincent Mailhol wrote:
> On 22/07/2025 at 12:53, Luis Felipe Hernandez wrote:
> > Fix kernel-doc formatting issue causing unexpected indentation error
> > in ctucanfd driver documentation build. Convert main return values
> > to bullet list format while preserving numbered sub-list in order to
> > correct indentation error and visual structure in rendered html.
> >
> > Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Reviewed-by: Vincent Mailhol <pisa@fel.cvut.cz>

This version keeps readability in the plain source.

Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

