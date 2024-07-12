Return-Path: <linux-can+bounces-971-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2A92F3F1
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2024 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4461C210BF
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2024 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB250804;
	Fri, 12 Jul 2024 02:10:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481108BE5
	for <linux-can@vger.kernel.org>; Fri, 12 Jul 2024 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720750213; cv=none; b=INtAcAnpAtFBrGzJh+06bKk47qOrC4zVCU+IpLGwmqsQCEcBIEvrwAM8WNctC88ugNRipNSUezVrgCNB7A99/1jIRJfNyZOBSDSidwxnPCNCCRxFgCV9bHIEsXY87kJsVseUq5xld/VWHuo6aIFyJ3rQz0WpSGoe9vIW3xCXnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720750213; c=relaxed/simple;
	bh=zRrxqnK2CW3DjLA9T0yafIF2n+Ub0oIjrzxR7x64jmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PE0qO7fAVq7iL+6+i+ts1UAqfhiMnk1YvO0tmUlP4hNF0XIcQ9V/NqAauXEPoeZsvp6yqfPsop37aNtqOAw5gjnLYlZaRUxBZD1Dga6nr0tTKEA8uFaseZg1xVRu37W+zvG49xWmXrBDMlRnaB/bEW5/AO1aWQpCkQPVOraTnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-781f5007950so1312712a12.0
        for <linux-can@vger.kernel.org>; Thu, 11 Jul 2024 19:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720750211; x=1721355011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRrxqnK2CW3DjLA9T0yafIF2n+Ub0oIjrzxR7x64jmk=;
        b=DBkRkpP54iNq6YqPX23YlX/+Mj4+FrMmnDEp5UVxN3efwKftoaKLTmyYT0vDuk2JFV
         iQC9dcazIPYQnxRCAKbjo9pXtvdh8r+Hpzblnft9fEr2d8Nbqmuq0OMuEzcVNe8FWuCg
         72+ApzwnL3+aplaFXOF9kQrXfwLq/W2N+kZQsp86IZxTK0ANpzz7YozaGOIfjUYwWa+r
         NSffjneGul47cIp+GS18bLORUI3L8Kcl4Ojx5WkuAIfWtChbHc8MO+cxEDxWa2XQmeAn
         sGLlXfGBV3KrvHkGthS5Jzx3G8XKcR7/jCgtwSewzjFB7S/Ufx2mBzVhFeMzTygTdd/p
         qeTQ==
X-Gm-Message-State: AOJu0YyoZr+rxfKrAzhmBD74EWPXUFIw6CUz0u8FZ5i1ehOTNMG9gNXy
	sJShGX82RSRDRXW1nmf2Pho3EoSJk9T1Jhept/4PoJUr0JmNF6NL5BuFdEzPabtoonBanbck44F
	/IDA+KLMMqeljJ9PnzqjeSyrZlfJMMkki
X-Google-Smtp-Source: AGHT+IHiJBMKbtHWyT7RqcTLVAMFQt8whK5V7cZBAPIhqt0SPP/STbASHiuM8AxC6Z82eDU+fVWXb58d9xS2JVuebyk=
X-Received: by 2002:a17:90a:43c6:b0:2c8:660d:cc2 with SMTP id
 98e67ed59e1d1-2ca35be1c8dmr8800347a91.4.1720750211217; Thu, 11 Jul 2024
 19:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711135451.2736466-1-martin.jocic@kvaser.com>
In-Reply-To: <20240711135451.2736466-1-martin.jocic@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Fri, 12 Jul 2024 11:09:57 +0900
Message-ID: <CAMZ6Rq+FMAmSku0kPHvG+6u7debxtMCRj7fs1X8zZphdY4fxOg@mail.gmail.com>
Subject: Re: [PATCH] can: kvaser_pciefd: Use a single write when releasing RX buffers
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, extja@kvaser.com
Content-Type: text/plain; charset="UTF-8"

On Thu. 11 Jul. 2024 at 23:22, Martin Jocic <martin.jocic@kvaser.com> wrote:
> We should return from the ISR as fast as possible in order
> not to mask a new interrupt.
>
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>

Thank you for the patch.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

