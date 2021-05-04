Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5F0372A61
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEDMw1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEDMw0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:52:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D8C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:51:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d4so9288832wru.7
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7lZvaNNisYObkasis9rRCqaxlH6jvHZDXPrNdFmmCY=;
        b=F13xuFDuXOAWh5x2keozSwGCRlCYTRGtfN/AgstcmFqMZ4UzuPhutoqugo0RnRkZiS
         nlbo4qH0qUtW6grPq9X4A0yhvKhSiyD0K5PSWBe00fkJ+9vjV9KPcig2H9CtUS0fkM/c
         DC3gQNSD7O70+sMVIQzo9l4EblkPTv1z1haJt9u0qZvjwlb1fdFB3WDdAO0swoXD7d2L
         6K4k1woUCIuMT8qmHyPwlsTtCZ2Qy8YVcjyfHSIT1pujYCXNgkVlJ9V23k4f9GP0avR5
         zoWc3BcvWl+QSDf8mqCak6OAnaVXGZONjbDjScIbfs28W8gmHR13n8mbqo6ymsEtQWOE
         EBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7lZvaNNisYObkasis9rRCqaxlH6jvHZDXPrNdFmmCY=;
        b=pL7VORlU4jJp+8Hp6X0GwmUki+ka7EA+/1ykoL1QriGiQY9IisrqNHHNphKZitlDaH
         T0BQwXWBUFRGS0O6m7iChuBvEWeLvXvX2twLgXiCpa9A4RYw0cmfyPu1fjeJ8TNtNFiD
         ViBf+gAOk3o7H1gdFTf9P3F9TXhPwIo5XvqrqPBktzkRqlvgSY2IPSV198Vuu8kIiQQB
         qN/VmZUUi4PLxkjINpn2j+IXz4rERxmkb8rPVoIrTJbnBPCdPeKF6JIruznRyDhRfmel
         t0VTQzogX6iB5E8Z9QVV1t0dSj/i1e6a81wwuIIdA3EN6DCglrZyOjG4/DH+nBROUbv1
         SzRQ==
X-Gm-Message-State: AOAM530Qi49NEeqLjXmhRiQj6hv12Dy0qBvh4qIJm9QULJ6nLE88mD3D
        HP0H3UfgR9rn2meFypfkxivKePwkNyLaW8Gk
X-Google-Smtp-Source: ABdhPJwe2QWEKXRGKRH2w/neznHfFQU8fMUAZ9BX6u+/yn3djxNxmIuH58Heav89d6V49qMfbthP9Q==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr31530865wrn.35.1620132690404;
        Tue, 04 May 2021 05:51:30 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n5sm11679527wrx.31.2021.05.04.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:51:30 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/4] can: m_can: various regmask-related cleanup
Date:   Tue,  4 May 2021 13:51:19 +0100
Message-Id: <20210504125123.500553-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all!

1/4 modernises m_can.c, using GENMASK for all regmasks and
FIELD_{GET,PREP,MAX} for ops. Maintainable, consistent and concise.

2/4 makes clear all the differences in CCCR between M_CAN spec
revisions,
and orders the defs by revision, ascending.

3/4 makes explicit the config of RX & TX buffer sizes, making it a bit
more readable, especially against the spec.

4/4 fixes whitespace in a few comments.

Cheers!

Torin
maxiluxsystems.com


---
v2: patches now correctly based on can-next/testing


