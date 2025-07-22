Return-Path: <linux-can+bounces-4024-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AACB0D3F8
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD907A9107
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA228AAE7;
	Tue, 22 Jul 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="ec9LZCKq";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="ZRRnQR8j"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1D273FD;
	Tue, 22 Jul 2025 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171035; cv=none; b=YKWpFPRRcTa4C2433I4lTtRxTaHxiQX0ZrAWWApMtwqVS579ZegMldeVnPfmtxtMbrfCafe+d6IzPa2nz+un0W7vspBSuxuXcGbUv+bCsWjSIciczlcXWMStwQiu0Bc1uDIqdP/ANWQ+fyIi+NRazO07elhWEGtSQJLOMT7m9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171035; c=relaxed/simple;
	bh=0ER8Oi/jWdnMSjU24pmXL/+FuCkHbk/CujAL/bqS8/4=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=HdrmB2fhm5BQhkrwxnq42K5di45b1dVJKW1zC+wmpDnBNB1qfGi58+aaQAA1pBeQMq6njuxU3opMFvKiLbnLhQJhA7+rfoX7VH03KrA07lV2BjCqrI3GdnJdubWKNLrNPonWf6h+4cCza502c5012kIDqOCYGQzy9UsAtOvTqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=ec9LZCKq; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=ZRRnQR8j; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1753171029;
	bh=XUoJqx+1FPCFGqroj3LyhlD2zFfnmK3x2BRB4HpHBao=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=ec9LZCKqwqNKY1YMkKxJtY3e+sGVbocnOTUlHRkx4jgsUHLVn4tMsuL+VyY+Ow3/s
	 9NGhbRp2NeROxlfo33nmOTuT2jTRVWsmKetG9zx4y9SRqQUVqusbY/AdGxLahwxGFf
	 fyXQe5PKYt9GrT7nH5/jMSIjrbrJIUqAXL3jBGvRsKaduzrcRgcVfWFpnz8pZIoKnU
	 A+MvjtM8qaMw7yfgpf8/1SxqnVCxQ0DUFxk2WKIXqG6BJvNLViNNwZeNS6FP0i9+80
	 mm8lm2OO5jShmfCQ+RS5PmAL6N03EyHJs+H8h8GMkIBKtBepw5cCPbVdbeVOzf0nUM
	 XZOmNBQ4/RXUg==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id 8E9542E4A0;
	Tue, 22 Jul 2025 09:57:09 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 8C2A74933A;
	Tue, 22 Jul 2025 09:57:09 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 8bFl3xiDcrEl; Tue, 22 Jul 2025 09:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1753171028;
	bh=XUoJqx+1FPCFGqroj3LyhlD2zFfnmK3x2BRB4HpHBao=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=ZRRnQR8j2Pypk5JEPQqlMMVeCJez8/6iiULVE+I7YebY5dQjKPFeUMrBmIev5onTj
	 /0m3Llmd1NCCS6uMW0S3EKT/Uxq/BFE7S2YkbDc5nfEBbrx5dv8eeTA/EAu2rRO3QM
	 bdHggeF0A1GZvDyvLF86HMRDXUMuVodm4Tjgy5D3KcH5PwR9TQtN1TbvR0Ta/Pgqar
	 5CuswheYh/MhnsaI51eDYnhNpKK8/wLPZTjZRdOjSrQw0u39gQvD+OCw/xxPRm9+2y
	 DHXZ8ck8gkKTAPOZ+bvEmmQAP4eddVzV9ct9etfYLmBistxk1xQlWFwLEUGZGQwA39
	 1cvoiAEZY1BnQ==
Received: from [10.0.1.189] (unknown [80.188.199.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id A04F349337;
	Tue, 22 Jul 2025 09:57:06 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
Date: Tue, 22 Jul 2025 09:57:14 +0200
User-Agent: KMail/1.9.10
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ondrej Ille <ondrej.ille@gmail.com>,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Marc Kleine-Budde" <mkl@pengutronix.de>
References: <20250722035352.21807-1-luis.hernandez093@gmail.com> <202507220837.23333.pisa@fel.cvut.cz> <399941c7-2ee5-4d8b-a7c6-c8ed7d85b565@wanadoo.fr>
In-Reply-To: <399941c7-2ee5-4d8b-a7c6-c8ed7d85b565@wanadoo.fr>
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
Message-Id: <202507220957.14122.pisa@fel.cvut.cz>

On Tuesday 22 of July 2025 09:27:39 Vincent Mailhol wrote:
> On 22/07/2025 at 15:37, Pavel Pisa wrote:
> > On Tuesday 22 of July 2025 06:06:30 Vincent Mailhol wrote:
> >> On 22/07/2025 at 12:53, Luis Felipe Hernandez wrote:
> >>> Fix kernel-doc formatting issue causing unexpected indentation error
> >>> in ctucanfd driver documentation build. Convert main return values
> >>> to bullet list format while preserving numbered sub-list in order to
> >>> correct indentation error and visual structure in rendered html.
> >>>
> >>> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> >>
> >> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > Reviewed-by: Vincent Mailhol <pisa@fel.cvut.cz>
>
>                ^^^^^^^^^^^^^^^
> Are you trying to impersonate me?
>
> Can you reply again with the proper Reviewed-by tag? ;)
>
>
> Yours sincerely,
> Vincent Mailhol

Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>

Excuse, I have been in too much hurry.

Best wishes,

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

