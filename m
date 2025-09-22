Return-Path: <linux-can+bounces-4823-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD3B93706
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 00:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C240189D49F
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9FF306494;
	Mon, 22 Sep 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RLXI2VsT"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609372F7477
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579015; cv=none; b=mld5Ma+qWXb05hiALJ54vkq6RiEFPpBru7z4+Q/OdofJTeIfeYDDDBfixK4124KbMGQ2z1nxedzDlA5bSgwagwBLNYoqicksAAyII3vb1F3fwer0tR6nlTZwtHxbZ/HfDWwe/z5sZC5XSCxjs9cy4aBbBwwGUOlcgQQ2fkLDsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579015; c=relaxed/simple;
	bh=20hNPRoiSo9eeYh2/WqnMMEHn20AD8bo0nWMtUjzCwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFBYfaY0Rte6pD+AXjlaV3Qh3hT8irolhGWcNqbwSpxQ9FHuBYuEacYndwV+moQd0TdbVOh22hoBjN6jt8fxpLT2+JaAq152v+QvQGGFutn8mJfd/BujeLUtKOKedPwotnwfBpwRqR8PuwswoqqkrxbAm5/BsBnXgIE4/RgZMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RLXI2VsT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4cf068ffe4dso9058771cf.1
        for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758579012; x=1759183812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGENPXenRny8byjVhYlqWVAobXHkgm90MTEZWLo97eE=;
        b=RLXI2VsTyhxOfaaCJvkVjQtIS9Ae386+qLljTveQahzCCvVfeZece7v9LLkcAIZA5a
         8yMXPVhK8Oni8lTqwzcKz9wJWSJESy+kTPdGfgQz/RcRMp103Bv82RWWmQsY8Icxx+QR
         9P7aoPHNYdAajJ/5gIQWOMrY3yKlKFii4kMkqu08xemGnmEbMe2aPVZQ+FVVbiaF5hHe
         800e+834NaNBdGLtz57GpzZUrPvido1dvh8BtA2R50QfzkJI3UCCW4PK2exxQNGqSiDY
         8JPk6jKnVFLniQd6Er3tk9yul/zFUx9iKkhRA2eCGGb5efjxF09UBgiam7e2B2RurR+1
         zN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579012; x=1759183812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGENPXenRny8byjVhYlqWVAobXHkgm90MTEZWLo97eE=;
        b=rXDiTohv23/eWr+GwFAFcXGl3Oxp/BgAg37WB5u247Fh2MzAJ7xx9NYiXIItukCNtj
         qsQJHj38SG2fu4AFedBYw5pC+39x+AWksNkjBaD0WcJUYxWQldM7MFaBOi6lKwTvkCHK
         m5mH+YP+sd4cRKLXcbANYYLUtIV08pr9slaT9o2BqRLnZDXKdbO3kSUbnmqGn3uYb0sc
         SnBueVRbIFSgT7c4geOoziwpxFq/6OJAtnYZPVOeRpIkJrLzYCYDdtwKZ6OPG6T/w5uR
         mrA5Nj/5+1X18/eQmdz50jyPBFQ/EzPKNlvC2XDFekF1WmAncYJEol45ZVkhHImqRkiT
         8dYA==
X-Forwarded-Encrypted: i=1; AJvYcCWjiCxIxlca7OFYCqjhqAwpCKcZX4W90xbn0TTSot57BwbYkpyublSFW+XZz+GMVS1RqzVT7woBjf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHkuqBLbZiyZX9SRx9U/ZjGJvSmSWEBBLPeJQrQFHHbneC7LP
	8vwjC6BpYhNseW5k+S+14Nzxc6ZRaErQwIw/QlLdBUQ0KZMPVX0faRhROApUWzKXe8U=
X-Gm-Gg: ASbGncsGagK1mp/2mWD26e5/9vMOUHrwxi5Yu/YFyy5IdU4SjbJoF6S4WJYgSVVef5J
	KukCbRsregZJ4FeU9R4VXYBzyXB2n+iwGfqOpRn22gPqgnXUHY3tf5xtSk7DommvyedLLypJCW6
	pGmEdr5Jci2a578GaNrZrDl9k1YohNhSNCNJmk213T9NpzZ+8BYWsaazG2VjCqwigAGfoVtQKnB
	8RXWU2POVZSoDYc5c0yanIsS8SCgsVWn78gQOirpMjHyOZB2E3Zc9WrLy0sleNGLb45DmBh46Gt
	ytAnNE1MEZPmZE1VnedUJJQV1WK9We0zFvXVS9sf+hsf+HykGJ5IcG6aOxT57+ohu4x4YtcBim6
	BAQTzXYOa8Zl6AsXcqqzqTB5uW5Ys6aZ/pJssYy98uebwxXb6aWJ1f1TPb9a4QSJ1lSneq4f3JY
	E=
X-Google-Smtp-Source: AGHT+IHNwvXqEF6vOTcSYqQI5K4auTTQ4rpyZ5n9iBhTRimnCw1sNSJGb5xwuJq4ksxZKKYMV+a4yA==
X-Received: by 2002:a05:622a:138a:b0:4b5:e2fe:31a0 with SMTP id d75a77b69052e-4d36e5ded26mr5451791cf.43.1758579012113;
        Mon, 22 Sep 2025 15:10:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda25aa5fesm76607461cf.18.2025.09.22.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:10:12 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:10:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/3] iplink_can: fix coding style for
 pointer format
Message-ID: <20250922151008.25c7a19b@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:30 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> checkpatch.pl complains about the pointer symbol * being attached to the
> type instead of being attached to the variable:
> 
>   ERROR: "foo* bar" should be "foo *bar"
>   #85: FILE: ip/iplink_can.c:85:
>   +		       const char* name)
> 
>   ERROR: "foo* bar" should be "foo *bar"
>   #93: FILE: ip/iplink_can.c:93:
>   +static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
> 
> Fix those two warnings.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---

This is ok, to fix. 

