Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E618B7BA5DD
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbjJEQUq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242309AbjJEQRi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:17:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150433C273
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:06:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565334377d0so843312a12.2
        for <linux-can@vger.kernel.org>; Thu, 05 Oct 2023 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696521983; x=1697126783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBlF7iO/Uade0k+MwDdeDJdWk03YGwm0xACDM2TMKqY=;
        b=U02EIJKiGrGEl9WC7Rnrb4wmZMethvWVAZda6veXztinl7LJ1quFBRRtIj5daWlZbr
         Mxgzozi4rq4H/u6ovbf+aNa9azh7Qn8vJQf6872TNM1ldMe9ivK0PIx/t/u5PYhBcu4+
         oDVdyHy+FP0WaswnTErpnlzmtFILSfi9dCmVodNKikiFlser5IdlaOtH66NPf5e0CYIq
         lOmKCwPEpnWjVgetzX6ozC+pDoHLRG9tFwahlIYXOupXBJavJQ6w4zRbmaA+JRXF1o9a
         fDJF+mHG3apo8hNU4Y1Hmf56i63+ojBKstbX17IZ3hei+FeWUFKZaLEvsSk7FZPsoy5N
         6nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521983; x=1697126783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBlF7iO/Uade0k+MwDdeDJdWk03YGwm0xACDM2TMKqY=;
        b=ShSmOdYvO4ASUJDikqriCi0kCEoRtESjv5aDGQop2bjiEDjd6CDPvJPk9mDRjvcnvJ
         TJkyT5xubrMXDlBsdU7JooelEn7iOHicZwpxIBARL5nFZcqnaVhFUsDEKgBOupG4KbxU
         oX7Jj+DYSfZzqJFjpGF6zn4eAifGmghVnbTdosi+/f7TaJcB+IhVRBi6ed6XQjRolIIw
         fj4akmQNCy2sB/CQ8IQpzhCPp6kRQmMA4i6hSKdWHvgXb7+DzqUrUoX/eKB9lx13jeJ6
         RZ4PJae+qUXaSkiMPgpsrMMmtSBgNxnWz3SOGLmd5NjKqd1azi/qfcBN5NR1GlyuAWYX
         dO2Q==
X-Gm-Message-State: AOJu0YxQSB0RQp3o0aFGrf+WYH92yeyc6gJryR2fevf6ye7vuRxwCa5o
        r6EHGMS4kl0LketT9fqZY+zlXrJb1p5RLFjGCb2ixg/Yz6E=
X-Google-Smtp-Source: AGHT+IHZkHCWCiglYEX8P9jMqJXIYn4YO8Rn97K4U82PE6iEsLdNBFq/qWM9pwy4xAApi8CM+wY+RSasaYFMwJvsj5o=
X-Received: by 2002:a17:90a:f996:b0:269:85d:2aef with SMTP id
 cq22-20020a17090af99600b00269085d2aefmr5591962pjb.20.1696521982942; Thu, 05
 Oct 2023 09:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
 <20231005-can-dev-fix-can-restart-v2-4-91b5c1fd922c@pengutronix.de>
In-Reply-To: <20231005-can-dev-fix-can-restart-v2-4-91b5c1fd922c@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 6 Oct 2023 01:06:11 +0900
Message-ID: <CAMZ6RqKN+Ce5-iAcxrGjjMSU9FacU=CirUh+02PPNdEV7kOSQg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] can: dev: can_restart(): update debug and error messages
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 5 Oct. 2023 at 23:31, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Move the debug message "restarted" _after_ the successful restart of
> the CAN device, because the restart may fail.

You forgot to mention in the commit description that the restarts++
also gets moved.

(and I would not mind if you just fix it while applying instead of
sending a v3).

> Also update the error message from printing the error number to
> printing symbolic error names.
