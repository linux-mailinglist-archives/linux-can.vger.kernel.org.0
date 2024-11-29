Return-Path: <linux-can+bounces-2285-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03329DE8AE
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B5B233A7
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FD5588F;
	Fri, 29 Nov 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqH8jeLb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA812CD96
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732891133; cv=none; b=PR0LzmqsoDdyTYx/fZG1ouQPnHUMxXKZzHTmY0Upn4iUJ8NWN+uAZMLYkdnR1T8bQawms02HtqCR0NOyaGLKMrNEuId0f1zVnTn4OxPjNLLndTye8itKREBIL2H4qZ43RVY7obaCPKpd6r857ilZiO0Uz+SbstuVJQz2bEBKIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732891133; c=relaxed/simple;
	bh=VNJX1gG4W7AI6zwxcBLiTnPiJnb1yqnUUhRn5p8o6gE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TkA1tZb8fLaTaMlDCSeZMqkUH1A5TMBWGUK7fCWb7cssOagMZqo/uwh+fMPT0oXLagR9bICOXHbg08HICNE450iidc7/HE1kQR9e+SeNLR5Ln7az/8KTbGVB/L0Gm3lH3XmgvIk7Asg5JrZrhXheU2GFFCQfbpAysuaaqGn9NIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqH8jeLb; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffa97d99d6so22477781fa.1
        for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 06:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732891130; x=1733495930; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNJX1gG4W7AI6zwxcBLiTnPiJnb1yqnUUhRn5p8o6gE=;
        b=UqH8jeLbyBaC0DBnz42em2wEDlikeKWcA6AV8QGU1Tr1ZqQk+Ga94kMQGRgfFQFZDg
         GsFKik2UydLDDLIQEfCctBoupBM7LfMdXctN2FHgocojbLna81OoQdunCWQ3GZ/ScWkD
         /P4Q7uKkBIzeBChixYNOmey3fAfwBklCJy3sVUqjct7a8SguARD2aFp9e0qgGl44bSX+
         BUS+A0+/2pmkxUL9QOg27OQb6ZFmph4+QVEK0/C8riRlGyE5I2JyrrTHUdWDXVxPKVko
         8mnOgrG8LbbEnMN3d1MQcTgPFpe2GaHwV/OeSvRMI2tXC8om/H/ziP7tZHQFFmsWtUVC
         LsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732891130; x=1733495930;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNJX1gG4W7AI6zwxcBLiTnPiJnb1yqnUUhRn5p8o6gE=;
        b=FJgq0WSYMZOSx0rshFmWII0sWCu+jZyr1N1cAG2Bq0hgy/5ydwkvtf46qpNR2pr7MK
         dGdYr8Noe+7HQaVFRO9rfbXtMwrXrSvM1Y0G/l/1zs2f+EJR3HquDfyX4oR3nt5gQU1F
         o/6TlzDM3XYrs9XajEWE+IibZooEhLxOlx+OyFHDU+0BrAW8GjzJwn8tkkJdHKjgrWuH
         3tHIu7hluBKGwKnTdMolPMNGYKw446UAKmrgemjHSU/mCNXd/hppFbGDVS0QRZpA5sIv
         Xntbwd7MXggMM2WoJCID7Zle5qF6QsCgVtUJcFHYthktdo5aPJhokSDpVpVM+p/wR7cH
         inRw==
X-Gm-Message-State: AOJu0Yxew+61rlToCPwtFuD3QEamXdEDo+YgVL/NIsgoyuTrej2DVdbD
	KKo/QcYuk999DeYY4DEbDO7RrUww/1gLQ+W6tYri+pnpDSmoddh+9I76iXoUcxnTLURiSDrV/pj
	8OKIgjSlxIs0c5Xe1V1mI5P1JNYbs/w==
X-Gm-Gg: ASbGncsYrpFD9QuYSeNqQy8jbIOGLcHvh7fnNyiOTyKQhRHiAHt8YW4p3XcXN0TT6e6
	94xwny0Vyp2HEUI1WknpJjS9ZIi30urQ=
X-Google-Smtp-Source: AGHT+IHH4h771ApCsbp9Kpv5uxMVACpiTZrWE8Od7x3VbofGyqqtFRfadUvXonFo8VMFj4vCa5Ih2t0oEtcYQ0u6PLw=
X-Received: by 2002:a2e:8402:0:b0:2ff:d801:4aec with SMTP id
 38308e7fff4ca-2ffd8014b1dmr58519481fa.21.1732891129920; Fri, 29 Nov 2024
 06:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Fri, 29 Nov 2024 15:38:38 +0100
Message-ID: <CAOv6HEDyVO8wHjH1k_Af+EZT5ZrvG0wviLQODo1uuz9Kg=Cywg@mail.gmail.com>
Subject: ACPI compatible mcp251cfd driver
To: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I would kindly ask if there is a porting of mcp251xfd DT compatible
driver that is also able to load drvdasta from ACPI tables to be used
in x86 context.

thanks
Stefano

