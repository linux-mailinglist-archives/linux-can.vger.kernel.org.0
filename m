Return-Path: <linux-can+bounces-2800-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5377A330B2
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 21:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8046E167F2D
	for <lists+linux-can@lfdr.de>; Wed, 12 Feb 2025 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6A2010F6;
	Wed, 12 Feb 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9y8/lZ3"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4479201015
	for <linux-can@vger.kernel.org>; Wed, 12 Feb 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391803; cv=none; b=T6t0zbLGpk8qSjKkS3g5C0n5MsyimWDFXAKB/n+bnuV04O3JEHmxf5FtPihKpPKhWcLGjEBmxza3wIk6cJ2ESRabeIUzR2fHC63h8tfgXywslZ6qEiuLIb/mafMO8HytP6HKqVwCvINTS5KJdR6Zou8CfFibTfhXTVG1eExfrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391803; c=relaxed/simple;
	bh=ssxISYbqIRkbvnaFcjJhEW/tXp0Q96MBkx7mOgznJeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IqQEXutHJkqlAVqUoje/Zf7N4i+kbpgNtS+k6IE+MWqhkTQh9OKGJxwfnyhAQ8F0EmldgfLsp401+q7IcUNeggTT4lqwuCYO/NOHtbzQQbOpdAdYxktX0BJSckWgGzHuyt5/SuWCRdFmIPdbmXJxwNtfdsTU95obOY/jRG2NKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9y8/lZ3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7bc87197bso4363566b.0
        for <linux-can@vger.kernel.org>; Wed, 12 Feb 2025 12:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391800; x=1739996600; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+eX9RkWPUqKxYSGmVYuIBIEHNOv+HFjA64PYc6aW98=;
        b=r9y8/lZ33IMRdTyFn3g4qGQR67V6Mu6L0YElHErOd1viLfrISn4+zY28EUWWWvdVP0
         58L0t1sNciTWHyB1ZrnOw8ygtTg75udkRnwx+ziQZoQNy8dNp6dqzRumAgW5H+LnuTVk
         wCLJKst58+q0OGkXCWE5XcH11IhtIsET8dBg9YM9S1EVAuowzGIrhoZifXvuP7VnRhdd
         arGD8RzdPIqTACx/H2UN0KUup2lPJtI7PfYzujl8d7XELewNkDrtJqP4cATrfhXaIke0
         7MGcTYMx43Y1gegVlYd7Yumj4DZmRGEKV7Fa3NjixKPmhVUMMags9kLoDjDBu/BqhH61
         GAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391800; x=1739996600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+eX9RkWPUqKxYSGmVYuIBIEHNOv+HFjA64PYc6aW98=;
        b=OI3eX9s4g1kNzE4wMRT3bZH8pq9ct/vye2mj4IHgqVFkpDyKVxL9ogS/jz189+ZUic
         qRhKJrCkorRqGvpksv0j3kBruxHGLSgeOZHi3fV6fvGzQAre3RbCiMa+kKg76wswGyvi
         nb8awq688PJ5VFVCHGAHcELagEPiDH2FVKCAJdN/r+iph46z87SIJ6CDdsQJ4uAScC1J
         7GHzKSafUoBCdz9wif3U/EdUpGkoyyOO+UFG1U+yFUiW/4zfn9mQ11t+a51w7ckzFUdb
         Hasc/wNaF0BiNJFNerBjSy+g+mXkhCh30rN7ZbS/7m9eb9hXw3ElgA+FaLODZT9ju24S
         iarw==
X-Gm-Message-State: AOJu0YwKUH+JroCoQs5MCLh/NceKGe4c0DIDVo3RpEq4/NP1jntHWQtg
	PJDZlPjlcSdIvPRU9f5/a5xSua8Xfg6g430GUfS+Zxmo7yNPC/2ZQQqzrhegD4w=
X-Gm-Gg: ASbGncvLe8JdvFNMebgQvaftQuCOYe2s0bls7y5Gcug1W8m4GzXxbDc75RK9VJA1zat
	4aTyKm7ZEa9qzEiHdJcps6hic9BqWUkYDnI73yyq9up7xVJoq1rhnx7J3m32katWO73JCAVgL1I
	9RDjEZ75BlFCQBLo6D1Jk6uyatNrCb4A3wCDhgx3XqeWL+69MLM1w+eOMAwq3DnxcY/bb7uYdsY
	C3dumXAizgGHufAeysrX7leTX8dWwzGhWs28Yja6GZYK5we9e+pLdyRw5YL6qKqxfp8Fz+O5/3P
	JS9rdpmE5Vs3dgCbK3c8X5VF+HPGu5g=
X-Google-Smtp-Source: AGHT+IH1sz9bitoyqyRJmOGaNkhAucGIm72kVsJs9egn8Qs4r03fBs1raIajWKGkd2ISLHHqe1B74A==
X-Received: by 2002:a17:906:f597:b0:ab7:b545:b2eb with SMTP id a640c23a62f3a-ab7f3336b3fmr155026166b.2.1739391800086;
        Wed, 12 Feb 2025 12:23:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7db5ef658sm419660066b.42.2025.02.12.12.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:23:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v2 0/4] can: c_can: Simplify few things
Date: Wed, 12 Feb 2025 21:23:11 +0100
Message-Id: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8DrWcC/4WNwQqDMBBEf0X23C1JqhZ78lCvPbTH4iEmURckk
 U2RivjvDf5AjzOPebNBdEwuwi3bgN1CkYJPQZ0yMKP2g0OyKYMSqhBSKoxrNMHjnKCdHGoeIhr
 tsbOiU6K8mlxbSOuZXU/fw/yGZ/NqHndoUz9S/ARej8NFHvSve5Eo8CJzWxV5VYmyryfymsM58
 ADtvu8/N+d9KscAAAA=
X-Change-ID: 20250112-syscon-phandle-args-can-bd0b2067c4ad
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=832;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ssxISYbqIRkbvnaFcjJhEW/tXp0Q96MBkx7mOgznJeQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQMyKjkpUkesTLLZovjRSd/j+120GUJ9CII4r
 XZixpt+3G6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60DMgAKCRDBN2bmhouD
 1zEWEACWUsMK0NZmVZgTvpqpAIXEKSqpclRrxMlmmdrwF1FSw6U9UjHwwUz+XQCuv4FYYJQNbg5
 P7zQXwyA2K241mv1qFyYym7diaG3AEPdJZsiLoYYlVEDxY37Ot2V2bcYrowxVHrNXZJNENoKssv
 xQdb0WZvKhp0D8YiZ4C/lF/w7LsmfBX3nc2FYU+R+gAlX1nNUsrfj4DpWCsRW7X9u1u0FWd83wP
 6ceXCsPPjGXzqT73jN5Hi72Pf6ooAt7J4s5DSDTXSr02xqSvwzYXlpODmQJg79GqI9zDuZ5izAA
 WhDUSERtUOF1JkIyG75LIa9hPiV6RQkd3kVTr5BnbcgLNfLxzCd0PYxh05oTJ6RxYm0fw7tOn/w
 vzY5TpsrPUO8rN7vz3R5kj5ywd2NHyAog6dDFT+ZowVVt3ZIMMr+c03nqE+qBr0dfjVO2JzTN6K
 QZY08rqVg3aAc/A2D1eq0vcwzBdw9ZTDVM8ePBHuz5dKd35qP/xSuPr1VC9lFVA16oGZ8Dywnt5
 JmJrigP5mJ4qrEMevfxF3yiG9wm0Mfcd6HyGYj5+AHP/59VskEogTTam05E9KTwSIb7GV+/mnfc
 k6C7ARaeJJk1o1cBhTWDaIWMYlZMUh0xfXaT8ZJ38Nes/f7/sdZznGcSyPsRxyM194sRXtDX4qd
 dnzOj+j6OCrajkA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- None, just rebase and drop applied fix.
- Link to v1: https://lore.kernel.org/r/20250112-syscon-phandle-args-can-v1-0-314d9549906f@linaro.org

Not tested on hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      can: c_can: Drop useless final probe failure message
      can: c_can: Simplify handling syscon error path
      can: c_can: Use of_property_present() to test existence of DT property
      can: c_can: Use syscon_regmap_lookup_by_phandle_args

 drivers/net/can/c_can/c_can_platform.c | 51 ++++++++++------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)
---
base-commit: b5f8134f0b3e49bc49bea6fb43319b38f078f04c
change-id: 20250112-syscon-phandle-args-can-bd0b2067c4ad

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


