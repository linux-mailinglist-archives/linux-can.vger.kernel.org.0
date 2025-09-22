Return-Path: <linux-can+bounces-4821-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA13CB936E1
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 00:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25032A5846
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 22:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FB2F7477;
	Mon, 22 Sep 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DiP2mvyJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675222F617C
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578910; cv=none; b=r5ApqiF0fQg6qdTQZynFQzDVMjerL0CtvZvma0DvTkN+G0D9E65LNpFWonrxv9PFQxtRjc4+mVoSebtF259DpxkCgEFJWZ2cThm5rw9OcQ4A3SrA7kp4rGXxDEiFsuaI/AHO3Xd4LmLIo4TlOhRVtZpupBjMXCRG6ny5/jihN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578910; c=relaxed/simple;
	bh=Avq2y8MdAwK0oH1I3MtgdoQ7iSmzzMmfx5BVuSNgHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWiwydbW/PButC52pVW9GidzCkgTROIT9bRxo6xyjzoV3RGkGOgnUAcC8zNONnK6awv3DPnnUgkFzM/yRdUbSrLCaVIW+wH8zht1OHe2lV0ja32aZ72mYNyGTbWeU48mPZC0as/4oDi9A1YeIMkGfREob7Ko3S+KJGJhfKLoiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DiP2mvyJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5eee40cc0so48800301cf.0
        for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758578907; x=1759183707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjK8kSlRwyRA71ulpxBj11meZbRhX9iUJHgvPDIzMg=;
        b=DiP2mvyJuIZZFK+eJLPbZUHCc6UaBSc9TK3FZS151JBFLCG/GX9fPPQxPy0Sp4k1Fn
         53or6umbFGNkReYKf4u5ZcpusSmNM3dS3SqV22/YMulrgkPl59n0gbOZNKUdXgs5zczh
         KalQ9xJdgzNZbv7jbaHUSrjiuy47Oei0gsJjj23pSwIFD/2v1Ea1xU/SRxr+bH80UtEn
         h+dELNBmfhpx4lHWlWHZ+ChXXQdNQkgQV5+7vE0I3NA7HbLAk5yzx1cJYFtZvzr8AuCQ
         7fnBqcmkzX/GwV61QVDcge6Yruf3aynVZU+U7Bo/bx+EXeT9+N6WS8fEf14JKt0QZZbl
         aswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578907; x=1759183707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUjK8kSlRwyRA71ulpxBj11meZbRhX9iUJHgvPDIzMg=;
        b=DyrMj0MDSMacYn9AS7zjG0iIto8WMhxZS09FwmfY+Ge/6DfYp0FJejQdhZ9b81A7WP
         0vBeW5PYUq94XXbVCfr7OuT3QTGXAEOHEAugz0WeUJUYDvIYvHHJ5yhbhy31qjyv8WB/
         GdJlp4XWzdelDXoySREcHYrEcZKr6sif+rbbazmIj07ruoubA3zl4fN3FlUKsLDSisn/
         7+vE430pkR6/My9RNf8yTwiZpoVcz/FimFAs4ZLQ+pf/YeWXp4nxkD6crTQ6wCMwHMn+
         yBkHIYh70pC/MYSLmO0H8ESZfH947keHSncmy76SxQK9Ystm6AQuZmomQlUWlFNskPDk
         31tA==
X-Forwarded-Encrypted: i=1; AJvYcCW0GC3JgEJFZ6S2AmaeIbJd3gTF3F/D2YU79W4jXmH29Im4Y6raLX1050grrOYhIj2Nwk/Ju+NiUx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYPW+z8+IpZJexfoEmVdORME+gW06hmXbVy8hBJMY/MU9mPQe
	HB2lFdmECa/clT2bmUISibbkGE0ORZ+kc4pzkW+Y+fiP49GhJnsEooGRQkWvzAwGI/k=
X-Gm-Gg: ASbGncsQbPh6bGjHCq4RR75P7HmnU9KZ/ra1S57Bo4ZjwmA9r75+c7j3tkhd1W2WdA4
	JiCwPpIeuGtm7z4QqItjsq1qlRhgvfycVHnyg3Az9iWqqjq+8ifk/kktWqZXp+gcYtPDgkyH9ly
	vWH60KUETs7lLbb6mgkEu/kCV/ke+/LyzeGEl7h4J7DF2bK5ni8HA1GOKbN7UgdnzpipO5ux/Za
	RiYClUl8zh/YQqbbfHZklfmS/BFpzBNLYYw4QgFRMJgEZA3Y8E75okDp0Z/MXdEhYvkhJSMyD6m
	B3UquTF+OP4IiDDSY7T3g75kCs3Q/reFnEbQWkl/mMlH/FZy/0Y1tuasRLi7XgEP77AropZB8gE
	EaNmA0emfnrMMrcasz5pkOKCKdp/KyHJJLV7QBM2fhN69NoSmHCR/9XCvI+uw0FOkvTNLKTxiQx
	k=
X-Google-Smtp-Source: AGHT+IEz0icBL4xjkfXiOd9WdBXGddBAYbpiDBXZ680UQhfkHWQJ/JZKh5CbDmMzNtrP9ERLzyDGHA==
X-Received: by 2002:a05:622a:450:b0:4b5:d586:d74a with SMTP id d75a77b69052e-4d369db6905mr5212111cf.37.1758578907176;
        Mon, 22 Sep 2025 15:08:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4cfdd34b180sm13096701cf.34.2025.09.22.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:08:26 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:08:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 2/3] iplink_can: fix
 SPDX-License-Identifier tag format
Message-ID: <20250922150822.3fce0568@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:31 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> In .c files, the SPDX tag uses the C++ comment style.
> 
> Fix below checkpatch.pl warning:
> 
>   WARNING: Improper SPDX comment style for 'ip/iplink_can.c', please use '//' instead
>   #1: FILE: ip/iplink_can.c:1:
>   +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
>   WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>   #1: FILE: ip/iplink_can.c:1:
>   +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

NAK
Iproute2 excepts both formats and both are used in several
places.

