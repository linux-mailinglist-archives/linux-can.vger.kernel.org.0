Return-Path: <linux-can+bounces-1836-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2809B4891
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 12:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2EE1B22C7F
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07420513C;
	Tue, 29 Oct 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KKPTYpwp"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2213205E12
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202397; cv=none; b=HEZ44ugYd5ldIMWLLRzs1cVj06algKjnCSkonTTguQGph/TrXgltZyINd18rFDCAGoZ2iicsUNM4g0WdYSoMCm73WUaxr4jrKaZnKXu/I4nZjpbisnxxKmkyOr/4FR8m54qtwE0pUcXsaO7B/bvxdLUOEkAdyN/QN09mVMr3+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202397; c=relaxed/simple;
	bh=qRJCyHLXDHPViQRK0r4I6eZdcHjED1uaQM2TcWTM2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7/+Wago4yYpHuBaB7+OqnU0lCS9BIvmfSE7RiVQYushSGyMBSH6FBYru1Q+1fhB5JtHgQRHs7/5/bDQDYmM+2qDxPaYkDTvTALzqkvdyo+kizdVjSsnjieMquHcIEb6lcC8v6gFjsgUH7Km/BnRCBJuYf5tPzAG45XHRbMo0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KKPTYpwp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso6264807a12.3
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202393; x=1730807193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbw+NGEXr7m2rV0cbMmuavLOG9IUHHd4c12xVVX95f4=;
        b=KKPTYpwpGfJYnK8yiiOwUCNWDVQm+yMX+2hDpdwFuWDJ9OGSVnLvmfHnSrGLvFkXcs
         RvmZYOufCG4tGn2y6L+mt6R9u6KjKhKciJHmr/+a5o+cus1R7WE2ee9v7IFykQu5/x0c
         tQlIld4ZucFYl/LBHURhVuD9JYt7V1l6Rx25g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202393; x=1730807193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbw+NGEXr7m2rV0cbMmuavLOG9IUHHd4c12xVVX95f4=;
        b=c5WCa6V9HgoUHtk38sE5fxTQjDAPD0dVUVnqfWKr1MnVY6HgyTI03Ms8QZDXG9B8ce
         TPEl6aQfAEIEr1bUs5+Igx2kIp683hXdZJj/t4zQ8AZYwYAR405cu+gAfJYoHNnOxsoY
         iY4wqu1tM+6aN1izyHP1hjA38AwK7RVdphOxUpJwdmd1mu39U0E6mXetlJ9RkR3qBBsm
         tjL+wfTR9ykJbC4GfZqkwiRRVufciWw82GIwIwTxXPWI6PEYhgLCs+3gcdKhu4TVSKyg
         Z6W0LdmaegaeVtI2O6oDvOoE/n+P6jmKmSik3WuLAKjmK1bVD0cJtWvEs+QCjphDE7LG
         8Eww==
X-Forwarded-Encrypted: i=1; AJvYcCWUlJbntUt6CsosMnKxbOqespZa6ukQ+oO8H2LUe8dpfVCpxM0esS+v7wqx08OJl/tkecdHiLsfEv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1m+bJsHI9vPWfSRQHIIW00c1KyTf1Ig8bBlCVkvJQW7iUcx7F
	KoylDJOt1TjvtV2q8rY3cC4gNWFxa1d/MxP5tZUFRHKfcfsfJ0Io20dNMQJbCGs=
X-Google-Smtp-Source: AGHT+IEr9NBZlyeYnYIfXfkfSPE8h1G/DkRYurTn5HC8Kw95XILRDI+sujvZBHNAwQ/Z179qoYcvZg==
X-Received: by 2002:a05:6402:3787:b0:5c8:95ce:8cc2 with SMTP id 4fb4d7f45d1cf-5cbbf8b20c8mr8968166a12.16.1730202393242;
        Tue, 29 Oct 2024 04:46:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:32 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH v3 3/6] can: dev: add helpers to setup an error frame
Date: Tue, 29 Oct 2024 12:45:27 +0100
Message-ID: <20241029114622.2989827-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These helpers can prevent errors and code duplication when setting up a
CAN error frame.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Drop the check of "cf" parameter not NULL

Changes in v2:
- Replace macros with static inline functions
- Update the commit message

 include/linux/can/dev.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0977656b366d..da85c44808d5 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -168,6 +168,43 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	return can_dropped_invalid_skb(dev, skb);
 }
 
+static inline void can_frame_error_init(struct can_frame *cf)
+{
+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+}
+
+static inline void can_frame_set_err_bit0(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_BIT0;
+}
+
+static inline void can_frame_set_err_bit1(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_BIT1;
+}
+
+static inline void can_frame_set_err_ack(struct can_frame *cf)
+{
+	cf->can_id |= CAN_ERR_ACK;
+	cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+}
+
+static inline void can_frame_set_err_crc(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_BIT;
+	cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+}
+
+static inline void can_frame_set_err_form(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_FORM;
+}
+
+static inline void can_frame_set_err_stuff(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_STUFF;
+}
+
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-- 
2.43.0


