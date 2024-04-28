Return-Path: <linux-can+bounces-498-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDAA8B4913
	for <lists+linux-can@lfdr.de>; Sun, 28 Apr 2024 03:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100E21C20BD7
	for <lists+linux-can@lfdr.de>; Sun, 28 Apr 2024 01:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4AA59;
	Sun, 28 Apr 2024 01:27:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80708A55
	for <linux-can@vger.kernel.org>; Sun, 28 Apr 2024 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714267669; cv=none; b=Luz16K1acI1JJSVlcs9JBE4f9izteIAmiyVks0i/iHsigzNWRTviLR1sFeFSjQJm6E0or8HSrqp9/ByiNNBBTQOjUIimj1ihBhDUmWZDY0Qd+/1fhFDiF+mBy5omuRBT+wuZNjnuqvLD8KOHWtc8bJWfUoKV2svPMpBv3tJWE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714267669; c=relaxed/simple;
	bh=rEZ5FVKKoMO6LP5Z+/A3fp35xZJs4skJTIyfYmnhuG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLdoTcS7aTV9WgoKXiyU4IYOlYFB7WSGEPvuXqF5mqITW8b3BDk7Gdf5zC7cVcfKR0Me5Lp5MJpM/1LzyrijlRG9GtDu+KP60zG4D+T6yR9RgXLsDfymYa1jMhafWey/5H+iWBvT9V6Ucx2WJePjaubQLJ17IpEKc5CeXViCGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso2961488b3a.1
        for <linux-can@vger.kernel.org>; Sat, 27 Apr 2024 18:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714267667; x=1714872467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zqYt7SrnMVWBmpDa2YZX+yUEDVD3PQs6NKQeX2h76I=;
        b=UuQbkjKwWQS7QA5b0x93fwWHvq4qQcgJmGWX/NWmVs9O/TEhoF148tA1FCgwKaCg/G
         Xs10fZg1zFtw2Z7RqYPTNeYRAWWyPczPuv/694JMfccLWtmAy62JBhJmjQbyhQkDYTSs
         OJL3u6/G3Uye4ld/uKgk4RA7cqkr44U3So6Z5d/X7jyon9Wa6XuHQGTdps1HqqNzcQ7C
         mLT4ei1mQaHTYwlnXmQ0dN/4PT0gg4dQCNRZZfqIuY0yvpp6Fl0eAjVa4S6zf2Mp5GuJ
         GmKcjhZDJMO15dktuuZnsA5JnSgrq5Nf1Oaa5B7tDKbiVWsx6elZK6PHwTgn3XtHmXYR
         MrfA==
X-Forwarded-Encrypted: i=1; AJvYcCVWwn1A7gtIo4d33IN/dG7VYeSwHTgRamg9t/kk+2nrVYRQx9dsEgh8nsLx71JLpDZrDAuRV5gjmvuBQDPWrvpxOeCu5Iw93jqB
X-Gm-Message-State: AOJu0YwBw/bGHTikgQJ2YeNmE9DGxgVzlRyRuMH8Bg3BFeea/Z00ZSG1
	0flpbWyiM9KdHiGRyTg/LtHyKTAzuEGuSUzfLpAeJ/j1gXaL/dQwhrft44tZlFFdV40ElV/LI0E
	7k1V9tAx6ywapxAIva3pIJPWADMQ=
X-Google-Smtp-Source: AGHT+IHIQj4x/SlQKFDJm2Gi1rZehZy0ImiCaSratuWzyWhzFQCZ46j/4znC0LKqPbyGEh8Dq3lcMrwyMEK42BeDHhA=
X-Received: by 2002:a05:6a21:920d:b0:1a9:11e5:2915 with SMTP id
 tl13-20020a056a21920d00b001a911e52915mr10711143pzb.27.1714267666749; Sat, 27
 Apr 2024 18:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427152648.25434-1-mans@mansr.com>
In-Reply-To: <20240427152648.25434-1-mans@mansr.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 28 Apr 2024 10:27:42 +0900
Message-ID: <CAMZ6Rq+MHEd85XJWzHHPYf9Qs9bwvz460CeDnW=uzFKDfr0WSA@mail.gmail.com>
Subject: Re: [PATCH] can: Kconfig: remove obsolete help text for slcan
To: Mans Rullgard <mans@mansr.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mans,

Thanks for this clean-up.

Le dim. 28 avr. 2024 =C3=A0 00:35, Mans Rullgard <mans@mansr.com> a =C3=A9c=
rit :
>
> Commit cfcb4465e992 ("can: slcan: remove legacy infrastructure")
> removed the 10-device limit.  Update the Kconfig help text accordingly.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

