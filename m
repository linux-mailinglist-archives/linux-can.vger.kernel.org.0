Return-Path: <linux-can+bounces-2213-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6E9D85AB
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 13:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFB2872F0
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E051993B5;
	Mon, 25 Nov 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="nGXw8J3L"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746141714AC
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539314; cv=none; b=obHdIlx6xtyoYrgFrHCUd70oUL/hc/83ZZ68DgBhijkMA/2IBbl/2UQD2J60/0EUzqH7sLgRtLnFOAKrt305p1wA1bGz27nHyrmV485+csprAjjrCAbLTOSf4oFB9JhPcIGDCS+5yGLJLaegcuq/ig48NGITySJGAoay5XfGhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539314; c=relaxed/simple;
	bh=7JrBS0MREudwVdyxcrpBrh1TpT2279Wls17Vy5ca0Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSMBdhJ4mBODwpU2IwzEYdOhB5cDuF6t7wLKhsLIY9/wWZ0xQACrGYJ4+ecQA7gXiTu6CQ3GcA3krpuOgYEMSgJfDDUijP6TJJOjFyLrS2HT/nGi8hv+z1OAnqn1QgQYcJ7Jp+Xn2PenvrYNIZQouetNFdcEncLW5afd8xkI+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=nGXw8J3L; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a76156af6bso14987185ab.2
        for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1732539312; x=1733144112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JrBS0MREudwVdyxcrpBrh1TpT2279Wls17Vy5ca0Ck=;
        b=nGXw8J3Lig1OXpIUMJJAb5ODq3AFUbPrwmK7HT73NqGaDN79ItzcbbBHKpW/8goNu5
         QU5+hoLU4VmU+XLyYNOlLMx/1yY23iasuMjAszb6X3eXCIGX1tyFMtcOeMyRoveqSVtj
         l1wHAflBfo4KNQ4uLzzTB/MhLKLvLTuzytE0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539312; x=1733144112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JrBS0MREudwVdyxcrpBrh1TpT2279Wls17Vy5ca0Ck=;
        b=FuG1KB51Wfk5iD05bisw1CAXPghaB4PbKbP9pyzSOqGMGTG2eo0Bn+zL3JpFFZiq01
         wvDtDTMOfV4AHr6yIbqaPoVj/zuDLo1wwO5/ht74K9+Su1eLWuf2CI2X8OOwoHnDF8qm
         Wq8Fw38/VlDvg5fssUtbe8eXP4zFr3ZurOIhStk043MsnRerB9F8CrGwzVVP2nthKRZQ
         6iT4Zm5xaOON93GDUteuaWej5LBuMwfPupm/ub4WwcJGd3zJk64pX4sNKuivC9xPTMe5
         i/tGXZ2IFlH4vmBx09Eavp1YPR9I5GbIUd+DTxsJZsZqWpJhSWY9MvgKq232p7xXETpK
         S4ww==
X-Forwarded-Encrypted: i=1; AJvYcCWWcsK+MZ8w0gm+lO9ngPC9jDLPJTy04j5RCwPk7sf6j+71MJPsaZ3QnQOB+94sQI0S1xkzUDIs2G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8UEuzYo+pI2TSYaFL0DFGc6CYzt4yVp7C9JPEwV6wmdBjmFV
	pZ8hOa8zqovppgHMuzeUCN422heTP/1HWMpC5I2c0r6pFpBlZX3As5aHcWmIJg==
X-Gm-Gg: ASbGncsRE7t1VZH28ja0DGUqOlc2V7xvbHYEjH7JDH43+09ztOixXzlO0eXBHi2bJKc
	iyMTbOeKms43gEPk/fr4IOpGBPqvZQNIvfqEtJ5XCX67DPzIduIKSBjxytdWwW370ALrXXc4uwb
	v83+ZktOyr5j7zm8p1IbR1mKmNaP8aWtyWoiwNmP2DmgqcfHdMTD0okiflLRsCNtvNYTrRqVetV
	YKt1ygQcTcLtUsNr0zQMyqeN5lBYGaxF/Wd73ukPriV0X+bpTgqI/Oz6x18iRDPyp3T/l5OLio7
	zgSPNkM=
X-Google-Smtp-Source: AGHT+IFvJvjZmwE2PphS/WvsMjFy/aOk6h8Wv85SSPPpbV4dlnzuk3no6MQ1F8GzH8qxC1Oyw6uw3g==
X-Received: by 2002:a05:6e02:1a88:b0:3a7:6566:1e8f with SMTP id e9e14a558f8ab-3a79aeade39mr95549005ab.16.1732539312600;
        Mon, 25 Nov 2024 04:55:12 -0800 (PST)
Received: from SE-151.formulatrix.internal ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3dde07sm6595199a12.59.2024.11.25.04.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:55:12 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: mkl@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	mailhol.vincent@wanadoo.fr,
	manivannan.sadhasivam@linaro.org,
	renjaya.zenta@formulatrix.com,
	schuchmann@schleissheimer.de,
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
Date: Mon, 25 Nov 2024 19:55:08 +0700
Message-ID: <20241125125508.29533-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125-hulking-liberal-stingray-ea500c-mkl@pengutronix.de>
References: <20241125-hulking-liberal-stingray-ea500c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/25/24 7:48 PM, Marc Kleine-Budde wrote:

> Can I add your Tested-by?

Yes, sure.

Regards,
Renjaya

