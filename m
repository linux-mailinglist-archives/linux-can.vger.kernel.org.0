Return-Path: <linux-can+bounces-198-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27084989E
	for <lists+linux-can@lfdr.de>; Mon,  5 Feb 2024 12:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A89B2A029
	for <lists+linux-can@lfdr.de>; Mon,  5 Feb 2024 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD531758C;
	Mon,  5 Feb 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKpfWKvA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9241755E
	for <linux-can@vger.kernel.org>; Mon,  5 Feb 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131879; cv=none; b=Bs5d2odfVZNTTZD31mGvBH10qyyaNF2z6LrymP+sQlIvo9aBvP4hoR6TT0hvBPxDif+jdVDQ9QJ6aZ7uRcumUfjezGnID5aSfZLcvhGDh/J3WFckI+wVb9jtNJgnRItf2dxAU7dhQnP7kt2v10VDAjNShFnIAb/9mID8Y4rJ+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131879; c=relaxed/simple;
	bh=ag5W1sGcj9NSPSS5lDZXA3wHwPD6Rk0Int1M6gvHbt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anP7S9VYGk9TA5WNe8eO4pxNWqsJbHWDDL/T9M8iFnLt+flHVPxnkFJ/scVl+Lsa0t8cfmLLd04wIRhT/rqkKuGnpQYi4rTZ9IjNzipEml2n4HSkB8ufgszX8MFwmBUqQkkj5gohOIRw60yg2Uy/2qozY8eHYIhh4Vz7dyGg8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKpfWKvA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da202aa138so2671304b3a.2
        for <linux-can@vger.kernel.org>; Mon, 05 Feb 2024 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707131876; x=1707736676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hpHZe4SwzPJoy+eLnrcnv4h8qrUqnKE/U5EXPEdu16A=;
        b=dKpfWKvAgAD8lPyKxCZ5P2Mqm9bTLp8EI0nRpJvyfpAStON0v9jlfheciu/CmqaBhI
         DOIOIO7LLtmDmu9kLzTo8tLPLT95R7Tx5bbeWR7WfWAXC2EkLhnGCyIgpHbMziQwUw8v
         9V/G7JcCc7UQ+sdeqonMoaivVayJMpAAbwCJigSbyBn3AnVOsGiUTgSx2/UOJTYCmm/S
         +i4cKNszZAjLWkZ5ffFPhtLPSsyBwp57II0E2JzTPO6gpNnTaK+A/v7vys+zFtHIJ0/q
         WZj96umno+1FTrO9ETbDEtSzAnCSTzk19+/YXRYWVbKDxWGhska3aGtXBwFfmSN11yz1
         oVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131876; x=1707736676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpHZe4SwzPJoy+eLnrcnv4h8qrUqnKE/U5EXPEdu16A=;
        b=GSav1XOA0E3HGvjgRKjvtvYMN7CJXXh0fyAwwccipA0qaDxIz7llhagA6vAKO/nK4y
         UOKoiMbqeXl2ROqTBaaOaMm3CBqt0cupiF6Jirwd2PF5xz9ka69srR7H03hZcZ94Cgn5
         VvMzXpo0duYhkt5IA4Rt9nrXf0epCdBf5SlrMVWrOPowUoFaIQ0ygccd5J+G1Fh5/QJO
         DZRMgKeaqIXCCSu6NSpI9zxATru905hUzGulVEFJGaFUW1EnlbQj6Xctc2ANUbXXDwOE
         SKxyUED2Uk2O8HkgbaTmb7ISULfqBNWmIpM5kNtbm0B60RvY5/k2SPA0VjLyQccgJX7G
         CECg==
X-Gm-Message-State: AOJu0Yzqti31pTUEnnaFDfLRgCEkfTTIsSwEdOT2reSq1oHTiBEdqXmC
	V40b6mpjezLtleTORwDrC0xH0y0sMcBH6b+szmt/COhNbXq0NOPgbARCWFk60ic=
X-Google-Smtp-Source: AGHT+IEioo67jn2OUlpm1V8XrGWbAW1lPMuCaxzg9EZlS9LtmEo0hOV5psYbpbPURUYxhKUowf0QBA==
X-Received: by 2002:a05:6a00:2d04:b0:6db:cd50:a716 with SMTP id fa4-20020a056a002d0400b006dbcd50a716mr11245455pfb.1.1707131876026;
        Mon, 05 Feb 2024 03:17:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0fXxL7jDAMn2AC9Actope1MGSFS5W+shOU3mnv9zHUDK7ONpZrD/BydMzwwFF9iwIcrTL/Qg5XqUESaMmOuLpYs89SLg4wAS5Iuq98zE527i8bskA
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id q7-20020a056a00088700b006d638fd230bsm6574756pfj.93.2024.02.05.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:17:55 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/1] can network drivers maintainer
Date: Mon,  5 Feb 2024 20:15:01 +0900
Message-ID: <20240205111743.920528-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a single patch to replace Wolgang by myself as the
second maintainer of the can drivers subtree.
---
Hi Wolfgang,

I do not think we had a chance to interact. I first posted on the
linux-can mailing list in September 2020, at a time in which you were
not yet active anymore.

Right now, you are listed as the maintainers of the CAN drivers
subtree together with Marc. If you agree, I would like to take over
your legacy and become the new maintainer of the CAN drivers subtree.

Please let me know if you have any objections.

Thank you for the past work you did for the linux-can community and I
wishes you the best.

Vincent Mailhol (1):
  MAINTAINERS: change can network drivers maintainer

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


