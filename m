Return-Path: <linux-can+bounces-716-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58F901475
	for <lists+linux-can@lfdr.de>; Sun,  9 Jun 2024 06:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335761F21961
	for <lists+linux-can@lfdr.de>; Sun,  9 Jun 2024 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F02175A6;
	Sun,  9 Jun 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlYDwFN3"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0217550;
	Sun,  9 Jun 2024 04:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717908896; cv=none; b=sTvhveZrxaYmTQ32gOKRzZL9yonjCjcJjgtsvqLwMVraFdmyGNSQAS+hO66T0gyP0Y1XjfbCREbq3fJwR4VpRv4ROxnjoRFluWuqI0PfN3B06lc5I99zdWCJRLEJMvSFJZIMX0xuLk29uHLjYZTH/kuuMyGOknXs2VqgZj0sDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717908896; c=relaxed/simple;
	bh=FL7qskUleGjn84uH7bH8rrNNveYI5wutZRKPDHnrOqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvrgVEfhV92tyLJ3kWde8u4MWE06QSu9Td8mRshm1iaBbxgTcP516nBVrBqpddzEuFoJt1kE8unuVG83QCxsb0TTTJRJ5W8cYY+2gVP59WolhWkVm/W2inV+upSEBM1CBKCAFemyox2hKBcJ1v3WCE2kjj1IIIVfp/fjRC/VnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlYDwFN3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7043102dcc1so439006b3a.2;
        Sat, 08 Jun 2024 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717908894; x=1718513694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8faibjiM68wwxkYicrR8R+K2WuFNuCQ7y9NKR8UlbTM=;
        b=JlYDwFN344oJPlMweZHpMlzb2rLJGr5I8XSnDKiU8MJFsj/ez8f1AwEhwOiTP5BcxK
         KZYRWBs3XxSBLhQB/TO/7Qi4Xf8gW58+9DNz+RI7kVCxCKpuFRjrz6X0rkoBGggUsB/5
         FBKm7PrCeDx8wpnVN2YIOfF9XtYgSaX/DtbiwwfMfTQ0G1FoK6u1bEwOJnJ9f7ZIEs29
         NvCPBK+mEmLzieJ1gJZXvSIUNtZ5AaMbyTrz529ppISltzP0lvKeTNVBgRJ4N0M0402Z
         3JlsKt+MqjPZuJDCu7eJkCFW/k/BLkJZ736ilKvI6rWTl7PEhYh6rH5YSfkJrvKKwuoR
         csuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717908894; x=1718513694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8faibjiM68wwxkYicrR8R+K2WuFNuCQ7y9NKR8UlbTM=;
        b=c02+LbkC3SqKTuFQYzjV7+cngyBlI/wDzCLmGzdVB6MwX6VgAgOC1EYdOnfZ0sRdQ8
         Ej8jDn2GWK7kB5mPhcCrjIkw8lG7EqYjfaUTm++WyPQzwSG/uXHD7juLddRzVoI6L1E8
         SRZB4o5TPaCd/Ucy5Ca2QoXXdLI24p4GjXQpDppJz2aUJY57KbyS17TsF14DdKJVCus1
         9cp9LLygO8e/cjkYb6A+nw3HPo3dndvNFSzm6Ch3J6Du2dpiRw9h3tDB4l4eo5FxtImt
         DiHrEbjkRX/Lp3KvmwtZBA12JJqAnWU3xLIH2rYioJhdrHB1IHdEsWjkBLNnX8pTewuy
         a6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU1yr2MENU3gyF8xMRN9zZ2cELiYC3oL0ee0q1kiBhtrtK1fV5hlDXIDWBvWxT61stuGMxtNxcpfjmIZJwsjHgf8SkAVjqMkU/oyxIYeqFe5M7aKk+mUH5+qGEnCc4dhHPZFRTs/0swNUki8RuLtQn+7f8d3LKW8Kz26a0LlfUiB234
X-Gm-Message-State: AOJu0YwyJA1afoQWq9cUI/NQOetzWGSmLtYJNhu5eOvxrm001RgCBxaA
	S6HGOyCv7kxWaPCNGdmRP5Vmw/35B0vrlwEWSPl6eZDQoObmts6uJ9LT7A/N
X-Google-Smtp-Source: AGHT+IH6/C30xPV/9LkE93afjQSqwWV/sSbcZXpwrAH0AVOlWZ3Ufo1XU+uY/2XCC4Q6/HjXXziMBA==
X-Received: by 2002:a05:6a00:1acb:b0:702:36a0:a28f with SMTP id d2e1a72fcca58-7040c629198mr7985134b3a.4.1717908893593;
        Sat, 08 Jun 2024 21:54:53 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041ec6f9cesm2284887b3a.78.2024.06.08.21.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 21:54:53 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Thomas Kopp <thomas.kopp@microchip.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 2/2] can: mcp251xfd: decorate mcp251xfd_rx_ring.obj with __counted_by()
Date: Sun,  9 Jun 2024 13:54:19 +0900
Message-Id: <20240609045419.240265-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
References: <20240609045419.240265-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new __counted_by() attribute was introduced in [1]. It makes the
compiler's sanitizer aware of the actual size of a flexible array
member, allowing for additional runtime checks.

Apply the __counted_by() attribute to the obj flexible array member of
struct mcp251xfd_rx_ring.

Note that the mcp251xfd_rx_ring.obj member is polymorphic: it can be
either of:

  * an array of struct mcp251xfd_hw_rx_obj_can
  * an array of struct mcp251xfd_hw_rx_obj_canfd

The canfd type was chosen in the declaration by the original author to
reflect the upper bound. We pursue the same logic here: the sanitizer
will only see the accurate size of canfd frames. For classical can
frames, it will see a size bigger than the reality, making the check
incorrect but silent (false negative).

[1] commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
Link: https://git.kernel.org/torvalds/c/dd06e72e68bc

CC: Kees Cook <kees@kernel.org>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 24510b3b8020..b7579fba9457 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -565,7 +565,7 @@ struct mcp251xfd_rx_ring {
 	union mcp251xfd_write_reg_buf uinc_buf;
 	union mcp251xfd_write_reg_buf uinc_irq_disable_buf;
 	struct spi_transfer uinc_xfer[MCP251XFD_FIFO_DEPTH];
-	struct mcp251xfd_hw_rx_obj_canfd obj[];
+	struct mcp251xfd_hw_rx_obj_canfd obj[] __counted_by(obj_num);
 };
 
 struct __packed mcp251xfd_map_buf_nocrc {
-- 
2.43.0


