Return-Path: <linux-can+bounces-5791-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC2C94F2D
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 13:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA8C3344772
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 12:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F16274FF5;
	Sun, 30 Nov 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqAgzCq1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F324EAB1
	for <linux-can@vger.kernel.org>; Sun, 30 Nov 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764504293; cv=none; b=bBkQpHIZDKq3kC2anv1cgaym2Foz5A37xy7qJgAvXgFGiERbhlB9oIgzF6bHkcAXhGniZu9Vp1J0sftRYdnJZMED92zONNtxR3sJK+1COlYptUFnGR3/S+OSjEL8GmfJmki7FDFxCTkPSTn9kL9TB8khsGFEcdzzCgg65Y+k1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764504293; c=relaxed/simple;
	bh=gON84WqW0f+/f35J43wWVshDZ88TdYvlxIrRIbIK1P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kStdctL3lHw1eGn9sReCue7sFZsJ8+VSy0Seh29AV2u24YhyVpsTF4d7ifAj/40FCbgUGJH2MptEyzZl5/ZzZCg07vteqsdQQsf/xuAxSRF6QRVX9VL/iYdZYvyyHKtrTZDiArxSqdn9BLJnixpij4nKJ4vXg/7DrIjASJyVWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqAgzCq1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297ef378069so32320815ad.3
        for <linux-can@vger.kernel.org>; Sun, 30 Nov 2025 04:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764504291; x=1765109091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAaTZksrz2vV6nzuwknM+wGM5fv6a7RY0jBpGOEw3bo=;
        b=BqAgzCq1rdLQ6aq0pp5yeiqwMK76OmQkJ5N2r8QexYmiJsBw4YHd6ODodWL2W/5Gy2
         yISGA52zhyLana9mZzRTvnc+gFq63Db2J+TI1JxRwhJhLmDDtAdd0hhkDALoGDqUaQZR
         N9edJQKKCYIvHOsV6tYfJY9CM2ma/JKfQ+KKFPypvL6oaQnvlgOD8Z5Z1f88n+YqnAGA
         uFd7g9WS+KgA9KpmNo6NMoApVFYmQiUr3gKDUgWqn3okOyBiwlanGRdXrmiKBaxM7b8z
         qm68wdBRNflFrzWlcA0sR4M3uMthFfHN9dJGjtivEkffVhR3kemj5bFd6CNUHHIXiHqP
         RVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764504291; x=1765109091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAaTZksrz2vV6nzuwknM+wGM5fv6a7RY0jBpGOEw3bo=;
        b=ayEzwRP3cEdP58b5q4iW/Qw95DS1aX1UKz32BhO2c40PPeqoqHTcvRMxy5EKB6i3Zc
         zJv8l0LT4M/jD4FjOTRvwi8FnAaVV50XClZnwdCtgYgkO3bzH6aYYbzwZq7oIVW5wT+d
         B6paPRZAoDlx8S5WcgKmffLVoz3lnRWa/RQopminfWDd+44XoMYyatDyHgulyBsQd7+y
         3P2Jd997w+qqylnjsHElWZQokOhaF54VXBPVk0EVrntFGRejktnLcm/7BuqhAas+oArF
         51gglkngOjggAO7la/DwApv4wSOyo2AMXg1xtw6Zov38QJx8i7BSqpVXjzaGsQLs6jEW
         Lwhg==
X-Forwarded-Encrypted: i=1; AJvYcCWD0aYVj0ZLtvjyFNHPj/gIJ68GtMVPBIisVCXLmOa7BhHz/NFD6RtE1k9dT1sv2Y+Lcl4dPS9h1Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mqsHplKMQnk6Ec4TDErVU2ParbsjccexPj7CIbFQtv6Kp43T
	XWhVMkrOQF8xdTJTUzeZuKz5sc9uYT6i/a+0ojsxlBy4A4F1EzsoQ1G/HWDqUcKFDJQ=
X-Gm-Gg: ASbGncs7Vt3ybnqcycFi1WvPz5F0vodWmKWuenigaux4kd1VcJqtyvNZ2CFyYvYuJRL
	xT1f17DT2a7CCiQa4QiiuDNV1OqovZBjuWkMX1csgLS9kFSPHLXZpZoOHOm+sfIa282cCCEK3Cq
	wAbKlS6JSfJfHxnGTz40YdmDdITfJMI9V5TVg9CFNtv0/AdwL/mQZJH8kiDyhX4juE1UVsYcoUU
	OMVVdWe80H29FLxQDU9UXcf1si/BRG8T8RQdc8FKjgY7sClg9nofZiNmVMXTab5e8Q1i+TAD1sb
	LzTPO6vvNVh551s/VyNThiuhqOCKwKinT6hFw8HIf6nP47zrWG2v2QaXhx6xPhsPij3naAtCxsj
	8OIB6WJ8pQNe8fVtMXGJKbqXIkmxeqwsvq4zb2YtpbRyRl0vJBKjPal1m6NDqIwvp0oAHg1dFI0
	QvMn8C0rD0P3zCUf94SzwBi1RFAdA=
X-Google-Smtp-Source: AGHT+IFMVAjDLqEUZlpMUKkK/mIWrRGhuwHT4XaB64ZQnRt1DmqZEvLxA5JKTARE9v6RWjdeNeHSqg==
X-Received: by 2002:a17:903:1b04:b0:295:56da:62a4 with SMTP id d9443c01a7336-29bab1bc934mr226576795ad.45.1764504291083;
        Sun, 30 Nov 2025 04:04:51 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ac99sm93713885ad.7.2025.11.30.04.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 04:04:50 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: socketcan@hartkopp.net
Cc: Prithvi Tambewagh <activprithvi@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: Feedback provided on question about KMSAN: uninit-value in can_receive
Date: Sun, 30 Nov 2025 17:34:42 +0530
Message-Id: <20251130120442.289280-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
References: 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Oliver,

Thanks for the feedback! I now understand how struct can_skb_priv is 
reserved in the headroom, more clearly, given that I am relatively new
to kernel development. I agree on your patch. 

I tested it locally  using the reproducer program for this bug provided by
syzbot and it didn't crash the kernel. Also, I checked the patch here

https://lore.kernel.org/linux-can/20191207183418.28868-1-socketcan@hartkopp.net/

looking at it, I think your patch will work fine with the above patch as 
well, since data will be accessed at 

skb->data - sizeof(struct can_skb_priv)

which is the intended place for it, according to te action of 
can_skb_reserve() which increases headroom by length 
sizeof(struct can_skb_priv), reserving the space just before skb->data.

I think it solves this specific KMSAN bug. Kindly correct me if I am wrong.

Would you like to fix this bug by sending your patch upstream? Or else
shall I send this patch upstream and mention your name in Suggested-by tag?

Thank you,
Prithvi Tambewagh

