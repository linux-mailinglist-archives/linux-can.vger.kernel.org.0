Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8B3309FB
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCHJJx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 04:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCHJJk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 04:09:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61251C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 01:09:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d15so10599135wrv.5
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 01:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snTjYxTGlxuiVDZk1w40avnbaMXlVt/xMGzwxiOEdWw=;
        b=u2baaUDlnRs7pm8ycWN3Syu1RQ+/ylLY8GYzoUigDATe4Pl/WNa1DU0trL0i8Pednq
         XvPuav8dvZVwnuPJqvg05WXLijHrYds6xKW4P0PH6E+oW3jcXPinD13bAmH0bu0wMguf
         F0mfzLKdpQjQCNxXa9/pz9GVZ+GHNHy5/YviR7rCSpVCo/uubrQ4AZKx1GdztZoRZoeg
         cxwe33XV7wGz8a9lJrDo/OSE8p7hSB8eiJ/gDLEDQBJaW952khvbFNt/aX/xYmWGYMsF
         nkkjF96kPzM1t34yvbFpf4fDf6k9qKkavOmRO39ESLDSySvkF1pxIrSJvdaS0YIOzzgg
         wrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=snTjYxTGlxuiVDZk1w40avnbaMXlVt/xMGzwxiOEdWw=;
        b=ro6pYaygzjUiIh3lWgmUr7LHZFWsqa0zztLr0d2k9lG/kkEG8SC/8YwSqeOFqND2pz
         Mrdwgp3L8g/arMzUOGyvb8yVWufpm827ENqTWXOXorJ04ISv2ih9wqDInn5utrz7kOfv
         r7Km7JEl3LqBvt2yJrQOY+3N/0KULsN2uo+AxsSpMT/6ocYj6dnQKYaN2VzEThIgPjZn
         GDW2jKrAkyYKgSdeECn6znRXMmcOsPmxWsMq3mg1XmJh1PkyE4G7aG7oraU5xLUnl84s
         uw/TRIIbdlNTuTkBW/ZFxYkyPW6e6vMhNnwUeSptrGAaCjS+5QZWmrYqW6mceYyaZ8YL
         uMpw==
X-Gm-Message-State: AOAM5307lJToVheqVfptbk/7RD2RC0YsCF+ZigKJ3ec6l9BoNiakJ2oU
        eAiJC8XCryQkheXeHopvbbgiiw==
X-Google-Smtp-Source: ABdhPJwB6W1fmdoaAnrLmlQPNJCTZuaCuCT23cViVYr5nbd1JARK5jai0JFA8ZlaGOii0L/zWEMgBw==
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr21582048wrr.274.1615194579148;
        Mon, 08 Mar 2021 01:09:39 -0800 (PST)
Received: from bigthink (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id f126sm17941237wmf.17.2021.03.08.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:09:38 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:09:37 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH 2/3] can: m_can: m_can_chip_config(): enable and
 configure internal timestamps
Message-ID: <20210308090937.jpxam3tdkw57qnxj@bigthink>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
 <20210305172015.1506525-3-torin@maxiluxsystems.com>
 <20210305213442.aiqccxbagl353k3n@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305213442.aiqccxbagl353k3n@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Mar 05, 2021 at 10:34:42PM +0100, Marc Kleine-Budde wrote:
> FIELD_PREP(TSCC_TCP_MASK, 0xf)

Noted GENMASK, FIELD_GET, FIELD_PREP improvements with thanks, will fix

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

