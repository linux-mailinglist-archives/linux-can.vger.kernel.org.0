Return-Path: <linux-can+bounces-1637-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527B99B3AD
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569AC1C22BCA
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE3B194ACC;
	Sat, 12 Oct 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHAUV1tA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9171A724B
	for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732451; cv=none; b=N9VJYBAtYr5Hn99TrfvNmORNM0p9d+NXxHHimMWxX3Jmmtadi2YxVZ90nX2v7839VxOAL0+P7pi4Y6C9gHUCDBo7sF77xwiun1Wc78H/8umihBsgZwerkpmnAjuKXhzup86851S3XbqKSHlGnk5bcakFntVttBcX4VhfQY384AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732451; c=relaxed/simple;
	bh=UPIYRyylfqxUxlxCNuK4wSlV+uPtduZ+pejBGOuRoyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTP7C7TzyQTm1IKXcvKZKoRj7DBUcKMXSD+teaE6u4P+O035XzH5CD080RK5W3ra6+WHSOeefLvXMxRo93pcNTzjj3jcgwNLYfv+IzJ6/y0RdOPPbNJT5h+mbtwFw0u9sV8L5acfegy6rN4/SSvVWmlOG3TdQkSDIYrecbZObOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHAUV1tA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so77549566b.1
        for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728732448; x=1729337248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPIYRyylfqxUxlxCNuK4wSlV+uPtduZ+pejBGOuRoyc=;
        b=NHAUV1tA2kvxpX4iIqA6yWiZk7EdUecKCfFwi7EKn38U/yf9kgmGpSwvvMQfO4CnZo
         NoXy+yxzn3TZGEgInRZwSPczoUSa/BueTpmzW6bopWOdes0jpK4Vz9iNflcy/CGRH1nv
         CocrK+qRF3DTzmd3ob8foE/HIXdfMzNBN/9R9e9b52aY71XR0cW/8+wWo+lLcd/we0lO
         wJnSGknJ4ZC0Rtu/H0ZD9diLGngE6k03PpzQYoWi20xN4dCow+rvxhqaALwK3j++gH/8
         itHayozEGR6Ir0Lp5HZ7H53qD/33/osB7UtqvIfguipY9POgswnQys7Xdav9snKvacv5
         XofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728732448; x=1729337248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPIYRyylfqxUxlxCNuK4wSlV+uPtduZ+pejBGOuRoyc=;
        b=SiMUiG3e5388JZkUI6jLVP1SLDg3UMCNEEAZ6wvN+KwwjN2DHjbBITBK1s6JsJhm1o
         3G03pH7t7VgITdN/GBN6VNA2jpujszajx7xPT/o9hHPPzofE6ZvotSYdXpJRryNHDPSk
         bRwFsgH+YCvyz6BdoyZbFxtXdJaOXngFzZeTDgdgng8LEoUfTEPWU/NNcFkLTWzrWdny
         iYqy/hhBH/H1OVCe4KKT9EGSngbL69v/eUiyQj9okIzZC4wI9jC8dmdlKzkhqLrsfX1C
         RYCsxZ8Sf3s9JVG4zMcG4es5wdCk7aftyK3ixko7MTaP+FFyAt3wDnL46QT5/Obgo/6J
         yYEA==
X-Gm-Message-State: AOJu0Yyvna23gF2vF2atnPVLIaFgrV6r0N0qFlfNsgXpTfyMojj8OxPv
	qCouRyUReWtvxr4fgoa6D7PGOdYqhImYbH1JokHaR8FkDatJcs8TN38pVEF5
X-Google-Smtp-Source: AGHT+IHZzHowOFw/I0wsXNOVMIFLd55ig4QsUEbN2FBKbbImVhIvT7wYhj6/FY2jLnoOJXLV2WgRbg==
X-Received: by 2002:a17:907:1c81:b0:a99:4045:c88a with SMTP id a640c23a62f3a-a99b850dad7mr503654366b.0.1728732447907;
        Sat, 12 Oct 2024 04:27:27 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f6655sm312099966b.225.2024.10.12.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:27:27 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	max@schneidersoft.net,
	Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Subject: Subject: Second version of the patch is ready for review
Date: Sat, 12 Oct 2024 13:27:13 +0200
Message-ID: <20241012112713.18519-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112522.18464-1-ak.alexander.kozhinov@gmail.com>
References: <20241012112522.18464-1-ak.alexander.kozhinov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear all reviewers. Dear Vincent.
Thank you AGAIN a lot for a great review, your time and outstanding imporovements suggestions.
I've carefully followed all your improvements suggestions and updated my patch v4 accordingly with best I can do.
Every single patch iteration and your comments giving me a lot of insigts into linux-kernel mailing lists working process.
Thus I am learning a lot about this process and happy to do so.
Thank you a lot.

