Return-Path: <linux-can+bounces-3725-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8607EAC72ED
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E293F3B29A8
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C71DFFC;
	Wed, 28 May 2025 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jM2+Odmt"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9F2DCC07
	for <linux-can@vger.kernel.org>; Wed, 28 May 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468904; cv=none; b=gF3wANznlL+cu4F517oazS8O4keJsGTrexp3ELyDqRvr3Xd0l51JhUB5haZKNuTexcsXiOYuWm0ezPMjxim4qTQxUSQoijsOjmRVih8reKn1gOxkJTWxxZH0RdYldOTZ02I/x/D/R747eEKCwE2E9e59eU62pWz2y9rJ6KY3HgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468904; c=relaxed/simple;
	bh=TP4g3pM0TgTnxJL9n8OY5mewVhM/5IQCcpgNBaXdkCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pOzbwLtS9fGZLwLp3Vzn5RKn4+gxH+JRFJZrk0STP6Yne/b1Vk8y3BStp3/Tmdc6PeTff/wfKbrIh+MIK95ER+9GetFc+BR5YIaQJQBNOaFKHe4ImO1hmq+WTliVFJanUkyGCtht4k+SvpoZ2c6z6cvEuPHf4ioZABFpq7WoFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jM2+Odmt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so27998766b.0
        for <linux-can@vger.kernel.org>; Wed, 28 May 2025 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748468901; x=1749073701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbYofBlz71EQRO1lv9/PyuZ+RZOLSaTxa0d/mX8465Q=;
        b=jM2+OdmtU5vb2xtqIJ0pKm6uPg8v42AthEkVHx79T0SqXuzZ5hjVmKLu572paP3OLm
         S6QgCzoiTCosmlFxrN0Uias1eOR+bDhbg3+pqc4efvwA5o5Axmtmnu5hicLNYm/Tzdup
         4yWkeTQOHMRVxFFPxp4K18X9HqpLV3pPQxVYRKDPmjrzbg3VT5ilpaq9BVAC2fN3LAYM
         xHOalqTqW5rAinmzRc1Xjrxwb7uigcyybqcGZV+1MMitJM011Oy1EAUa2yac3Lq4mHFF
         snfkCxOpWO9e/mXdUXr59UK1tFxsyDB7n8+pOhuphTsQlUrG6AK3hWsnXxF8u19vg5wv
         yZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748468901; x=1749073701;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbYofBlz71EQRO1lv9/PyuZ+RZOLSaTxa0d/mX8465Q=;
        b=D5N/aBNccE76j2Die7omHyw0C9Uks85v1ID9i6iuX5mRFMpBPQzgBWD1lXKuO4aOvn
         sTYk8K0UYNpMmOKvuMw92pfqqrEfJ4Y5WA1UKRGXJDWK64WnSX2E64gYnUwRygtLA1zl
         jRxMpNaHC8wV9exyETlVyXwJtwosKFp2p4rssA0NxHo6EsLLzYdxyQVcVBHIoMx5KpkU
         6COj62t5PBxNYxem1Nez1l6tfJ1mD2fKRHz6fO78a3x7D0HeIyRyZkKG7PnCwDvtaX6B
         xwQykWjEJ+L3hCuDitwf0uOgRHoh5xCh6vJZNWD0cSfO5XLlBKyMGaVpDHs5SOEzaje3
         M+/g==
X-Gm-Message-State: AOJu0Yzyy3o1UUkuog9dNRh8S+zDsoP3xUyFEISUHTyggNYWWSTqvPm6
	s8ZL9IfGnbzyakbh3xnbS3rK/qE9LmSQdM8+kA5HHrhIlTzuQidR7LgERTrQ0p9Wwx3ntkrfIJv
	U9BqZlSE=
X-Gm-Gg: ASbGncsYEDu95ojNlCF3i4hocsUjH9KUBn4Zg/YeeLhPbGQq4FQedN8CO/FkFvfa5NG
	P+4nwy9zCf9aFNc4L1fjkPKQ2SZOBpPhUyC6FBkrGsEP4vbZewWDHewfOCclwiAm5NBU/vGwxej
	e7VCcgXrQXWqGt7GqT4kFQhsgjuf8l0shY3fg53gdEMoTUmCbiCIZANHHQ0rwMtSmm9S68VOdHs
	qMwqL0bFC+E3I/ChKzfXMJz0WNH2yTAMwoj6n7MpWaqnO0a8nNzomQipckavry6Cc8pyrfKTlaP
	sMowxcD1j10VMcW2QPrJUa50F/hpChLrISQpvFVNSmA0ddopR4CLA0fh73mUTpfuB/M/3a+KPeU
	v3YyJ405QwJqU95ebJt5RiqV3Q+Vd
X-Google-Smtp-Source: AGHT+IFi0ukCIj+JX/0c3re3eKYKwJUvW+/10WB9wuKz+rRkMwsHABy03FuS/VVzEiAbJoINz0G6Ow==
X-Received: by 2002:a17:907:1c0e:b0:ad8:8529:4f83 with SMTP id a640c23a62f3a-ad885295656mr975076966b.39.1748468900593;
        Wed, 28 May 2025 14:48:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad3951fsm6404066b.125.2025.05.28.14.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:48:20 -0700 (PDT)
Date: Wed, 28 May 2025 14:48:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oliver@web.codeaurora.org, "Hartkopp <socketcan"@hartkopp.net,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Subject: Fw: [Bug 220168] New: flexcan-core.c
Message-ID: <20250528144814.17721a4e@hermes.local>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 28 May 2025 15:19:21 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220168] New: flexcan-core.c


https://bugzilla.kernel.org/show_bug.cgi?id=220168

            Bug ID: 220168
           Summary: flexcan-core.c
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: robbinvandamme@gmail.com
        Regression: No

Bit15 (TDCEN) should not be enabled according to the spec if dbrp > 2 and in
the driver it gets enabled when i set dbrp = 10. Resulting in RX Error Frames.


spec:
ISO11898-1:2015(E), section 11.3.3 (Transmtiter delay compensation) (page 52):
It shall be programmable whether the mechanism is used at all. When this
mechanism is used, the value of the prescaler for the data time quantum m(D)
shall be one or two.

The "prescaler for the data time quantim m(D)" is commonly referred to as
"dbrp" by implementations.


Kind regards, 

Robbin

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

