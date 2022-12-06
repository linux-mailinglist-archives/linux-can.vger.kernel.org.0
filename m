Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD86444A1
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiLFNeT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 08:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFNeS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 08:34:18 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E955252A9
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 05:34:16 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3bf4ade3364so151843337b3.3
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=plIPv+lnMIRiOFIe1dV+2tGtFokN2PX8I8Vl98aLxQc9p4eid896+qqRiD3cj5lfhx
         z1hiGYil0vHTQsGiaUgsnmnfx7Jsn5jop25MSUm4B/gJqMPAdiI+jqYGT4X+agKLBheY
         M4kLaJ4VYCDPrPdHz+VgEOo7V/8+VLiplXwZ5AxhmuB3ZAIj06bRIm6vVBa+cxsfUC69
         p7oJjaq1f7uQyzM8lwAnIzamm5TXtetx0xVW4yZv8ZN22bVtgp/BSdTYcvwessuJv/HS
         +NRVIrLiepTygJiUKe8fSjaB2LODMLrNxWaYxbpkKlISbamBewTovVPI3Q2nv//3DE4C
         AORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=1QbzEOK044EX3PG7f0pCi3twPx3NKiRSjmIeEDl2zGruBxF97aLcblb1PIb9h5AtDJ
         syCwOee2P5xJoMQK4Ba2teMxWg9KuWqmvB+iuPJusilRewPTF0ZJy8yNrrRQ0i1jVFjC
         7WpcjgiZSRfz8MYw5bnrhe4ct1DRGRal28pqkNqhBf2hShdt27aANKpKZK5lRS6fzSFz
         rJHRN3Jo0N+GbIgCRn7ICDvqRzpo14HRQpYp0H8WvFD4AWhlvaHc6LpKMUvc92RvrQcm
         2HK7IFM2qNlf8S7rejHfaNqsPIsgbeDIaEK+VA9tRJ0HXRbCYCq9g75MZlAVvx8yYXcp
         iPLQ==
X-Gm-Message-State: ANoB5pkzZ2053UAU68DcpG0mLWqRwTMbHy+UzWlHw4dvPGXMMZa3pq32
        VSgYRLxqQMjl0D31Zme3DXS0T7pr389qn4Ey/Hs=
X-Google-Smtp-Source: AA0mqf5LIFZdFA8gXtM15wCQVGRPhLW0DnkI1aVHz2d7yBbqXPecX+J2gwBesGTmYMSfngKxp/YLH/vq5s11h8+sSxc=
X-Received: by 2002:a81:5243:0:b0:3d2:2098:c5fb with SMTP id
 g64-20020a815243000000b003d22098c5fbmr31224498ywb.121.1670333655770; Tue, 06
 Dec 2022 05:34:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a205:b0:314:d2a3:70a with HTTP; Tue, 6 Dec 2022
 05:34:15 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrkojofofone01@gmail.com>
Date:   Tue, 6 Dec 2022 13:34:15 +0000
Message-ID: <CACJtp8tgBjrWD7ywREfL1yUK0-utTuArETnYq7P42dWiPJKSBA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
