Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011082952AA
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 21:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504619AbgJUTDU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 15:03:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56677 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502383AbgJUTDU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 15:03:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 585015C0105
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2020 15:03:19 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute4.internal (MEProxy); Wed, 21 Oct 2020 15:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=evenchick.com;
         h=mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=xN2EazyMGwD5AIvRSPmZG8tA6w1tjKVmmJkoG5x+7b0=; b=O2ZgqROZ
        P2lPBEde6fb3ynmVkZapIk5ME9OdiVlQ5Wqw/Sk1m+tzWTTaWyF4yQBPmP7tADmy
        mbmaleaoM3d3rKPTG3WZGqtUTobQ55YM6qn7YWliQMhi0qGJ2tf1xRW4DbBd90gp
        xPqhQ7knxcn1jgHJxOchiLoynOjvamvaph9mR/3Kz+Xi9KQlGbp/Q3BCMd6zN9PI
        9PRfyy1YOMuQHdFJ+wsXaQPJ/4/MbdIxkDI2KiUAkbv9SrOGAEKQZnfyBmf1Ro4v
        jvVVjCJTbkIDjYHsfAX21wByldLj9jKhdExYeEdSy6i0+x1p2Fi7q3Uoc8zTN8XH
        1Hgx227LY9EGpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=xN2EazyMGwD5AIvRSPmZG8tA6w1tj
        KVmmJkoG5x+7b0=; b=jNro+jyJQH78DAbPVG9m5X8/A7ycEOpZ6dYCtMbTelzd3
        b8KgtRbb0dB0twIMLv8NoiSVr5XnhCOfo2EPkk1ANnN7AWCJtppBqAkvwpuW8J1I
        FY2hxt6WZzFoON1dyPD/NWXKWLNXUC2lpHu0ivGqqCDfn/zr87VA700njps7hMi6
        N5py0+DWx6Y/S2TrtV2++OhhhEt2oJ3VRmCmnim5KWlqMzFE/3AZ2NY7NoFBrPrM
        o9xskZ3Q79NAsXqgyaJP0ES3fSzSJpnRoRu3V1QVwf0LhLqEvHzi8up/V83P4uf2
        EL/pler/KOyLlj7e+7JDqzikJ2Z+141E4NAAD8xiw==
X-ME-Sender: <xms:94WQX7MrCSBKEaIa4Oes-rhFUZ4FOlFrNwIE0ohvIbvyG09kT1fElg>
    <xme:94WQX1-JJKz4Zmk_a5nk0Z0X8DNPeN6Y3jrHnIIUQr3Ze5tD57Ybuy4SbMN4MGaWG
    TXgL-chQaQIBU2GVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfgfhrihgtucfgvhgvnhgthhhitghkfdcuoegvrhhitgesvghv
    vghntghhihgtkhdrtghomheqnecuggftrfgrthhtvghrnhepgefhvedtudfhheejledtie
    ffgfdvfeejjeejtdetgfffkeetudegkeeufeffjeevnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegvrhhitgesvghvvghntghhihgtkhdrtghomh
X-ME-Proxy: <xmx:94WQX6Qv7hu9YfxvZAIErcG3SFZqbBmrd5LqMFePc2FmA_UuxY6jTg>
    <xmx:94WQX_sMS0sXB2qubM7jhlp2ACZqZD9wLo_kWdq8SeNhyLin9n0f2Q>
    <xmx:94WQXzfNRVqb_zcBbkiMnxvTJmvc42GahRdXsEx62OagZnlJe6ip7Q>
    <xmx:94WQX9o5gt37PYdTNwCXgYhVrmFUK2pL-0hBmPfEKdYEr1X8TEomdA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 18E2A20075; Wed, 21 Oct 2020 15:03:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-502-gfef6c88-fm-20201019.001-gfef6c888
Mime-Version: 1.0
Message-Id: <ebff6876-57de-4938-8e9c-bf3994ec77f8@www.fastmail.com>
Date:   Wed, 21 Oct 2020 15:02:37 -0400
From:   "Eric Evenchick" <eric@evenchick.com>
To:     linux-can@vger.kernel.org
Subject: Adding FD support to gs_usb
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

With the new CANtact Pro shipping soon, I've added CAN FD support to a fork of gs_usb used by this device. It maintains compatibility with other gs_usb devices, but adds flags and options for CAN FD. I've put this fork up on Github: https://github.com/linklayer/gs_usb_fd.

I'm wondering if it makes sense to add this FD support to the gs_usb driver. Devices supporting FD will set the GS_CAN_FEATURE_FD feature flag to enable FD support. Non-FD devices will work as they did before.

Thanks,
Eric

-- 
  Eric Evenchick
  eric@evenchick.com
