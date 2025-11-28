Return-Path: <linux-can+bounces-5766-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D6C92D48
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 18:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E533A92A9
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383228C5D9;
	Fri, 28 Nov 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBxOAq4o"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0927EC7C
	for <linux-can@vger.kernel.org>; Fri, 28 Nov 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352134; cv=none; b=mKXqoaRziqSN9EfNa/KgCyqUCILemfm7uSH3iMJ1V92TMiKjg3JMAic+ljaJ1wWt0ZB1TBsLGyR2xvZQjkPelmHLZJTIbD32I0LcUGvY9RmAlJRPo7I/vQESUXuYYBlZT+xB0v4OR7/m0uJsgrqSMCE4mJBZZaefoNWHQACENxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352134; c=relaxed/simple;
	bh=PeLfNagr8bbCWo3x0R27Qo10YYvWfKbDul1cWPk2gGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0U6A2RQFfPpo78heqQ5BwZVorA4OjmmqYr4IBk0BTo6K3UXMWPU3PYYvYSeLASmOL2Pdrdoxcj+uxQWFQUF6p9Tj89UmbZQfwEzZTQscUC0j+BgYouABK+K5n3v19zRnLaT48pS1K+6Qy7dNJ3i1wP70ussjm7GAPb3LpO9uE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBxOAq4o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aace33b75bso2043653b3a.1
        for <linux-can@vger.kernel.org>; Fri, 28 Nov 2025 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764352132; x=1764956932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQSCgy88jUFBUBQD7anBVmHOK3ox7teRQN/7h3qNsK0=;
        b=NBxOAq4oqAUE6ZkntLnWBbFSasE5wbysubkl0EXC8mDfPoJcEIr5bbqHz5kTmGT7gS
         sbUPLzJvbUGBXb0mxwGUm152s5bkL2Cv2f1H09utQ2GPHWBGNxdoCPANMwXLAw6H1JA9
         zG/rxt6pbI2JCCyk5hDTOwGfb/aiIZ6dSA0AYOtX+6jGPSUijD1ZEcA+Y04aFFQuKfKg
         W/ZYfUaVPJpWkl8O+UNOskatElgiySSfI2yMgXzcUDxSTmAIj5v18iz8h33bT4M8J4GF
         UUsxnKNqj11St8043/OqcRUJSGfqqgW5a1Lm/HeHbl/kjkyip7otx5yTjweF0NJcZ1q5
         ozHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764352132; x=1764956932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQSCgy88jUFBUBQD7anBVmHOK3ox7teRQN/7h3qNsK0=;
        b=lj2royJCMZltRqPSoociPHu/noXXFg2vcTbJqFwJ5DJEAEepGu0f9lSyOT3TxqPukS
         MZa5wVZrZSpVHVPdzmo4Wnu6vJ/pTL5vkiy2/+jDF8b4kbLYjc0c79CL7RI8F9arSmB5
         8T24GX4CBN3KhjlVb2WK1nFZanh1fv9LjOWAnP+k716/tmYcAomosdDK1l5SNdkpv0l3
         b0Evs71jOp38+pCamZX/WEPhrtAlLx3CDKHwvrhWpAsV5ngaHj5QtePTIsXKZSG8kyVA
         V/P6mKgjihFRmjgh0wZDWlLJ8SZY1Y8s2m3t5VmW93C6KlCDlNe0PzDHIlnVXQCgKk5W
         cHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5E+DN+fDgZg7C4PmxihWslJjoyIV6jZ8aPWBZb47oyfYjNH+kSI1aIByfBymrSxl5mHWcJYtCK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnU/51jZc/fjnJSBiLVp6Aa04f0Lr2dI/qhsGXHGHQngKrys8s
	Mx9lWfMaRzWzBElj6v3Ggd+Sho8Fpl8LKnpI3Y4iy6/XQiDNZzGFz/u8
X-Gm-Gg: ASbGncs+D4vyVbVnD+YlGBXoAKd6SzjguRFb443KsAPIzeHu43e5pD3aAU0QUkOourA
	G0dFXJIqV+qPdd4dbYdhLm9+gmyQd3zikB1bpkN2tsq1U8JTxGdYdbh9xsNJzd2WA4lMlt9KM8K
	lPG6+rqYxdKW9JyJ5AmMaEymDBXAHSGSPLn+uOBpWrFr4I2ZXSCSUXfyYEs78JCTqm9HKMNFwbs
	Q7hbjDo1INOvmugT5tMo8QDQsbeegjDSruLokUD68LkhXVWg0bMIsF7Kn8x4hyqNlR44mT8bJm/
	4uGSeZhYHiPvTnb03m9Xeep2JmrDe8Tbb5IH65bwjWh+a1IFzm3Hk3BXBQ+7noiglWdzDK+WYi9
	FppzUixIAl3EyzvZqI3Utt2zASkmU2P+efw4FtB+FLc2OoHp1C6P/XQTYR+NJt1roaU/LeQybJh
	DVILXIgQZtcwiLbP0Aa/d3Jty0CaSZvr4YYg/HmA==
X-Google-Smtp-Source: AGHT+IHr4vLpLy5HTyT7pP+UTHL/e+zP6PbW1p5PI91eby2Wk62TA7pldEAQpyVu3l4oFIKXasfnxg==
X-Received: by 2002:a05:6a00:114b:b0:7a2:8529:259 with SMTP id d2e1a72fcca58-7c58c2b20d7mr28976570b3a.9.1764352132238;
        Fri, 28 Nov 2025 09:48:52 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b68805sm5655155b3a.9.2025.11.28.09.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:48:51 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mkl@pengutronix.de,
	socketcan@hartkopp.net
Cc: Prithvi Tambewagh <activprithvi@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: Feedback on question about KMSAN: uninit-value in can_receive
Date: Fri, 28 Nov 2025 23:18:02 +0530
Message-Id: <20251128174802.369044-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68bae75b.050a0220.192772.0190.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I wanted to seek feedback about this proposed approach for solving the
KMSAN: uninit-value in can_receive bug, can you please guide and share 
your feedback?

Thank you,
Prithvi Tambewagh

