Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829F732B30
	for <lists+linux-can@lfdr.de>; Fri, 16 Jun 2023 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbjFPJM1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Jun 2023 05:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbjFPJMK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Jun 2023 05:12:10 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB893C19
        for <linux-can@vger.kernel.org>; Fri, 16 Jun 2023 02:11:04 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19f8af9aa34so555948fac.1
        for <linux-can@vger.kernel.org>; Fri, 16 Jun 2023 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686906663; x=1689498663;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/YQmPfaNN2xvCaGQ4ZNNpbl3kHI7ba/jcD2wLQvQQJU=;
        b=btgMnNgmfZSFGKjVJqtNvaGjA/Kv4+f/iS4+Bie/GfoPfId1tjLxhqIz5KdECdAMq3
         z35lcHg9gOvk1XQcMdHJ4u7El8qlVB2u+WfoJsVJm4PDa7XJxLOXZNfjpJC/sITNl/f2
         gboSVTnaAlAXumj3GQcMk0vm6+DGuuytP/PXKaATWZ2e6aI7R+nEsxXbXL0YUE+U7OSW
         SaQUq3FjSZ4rgrfFQ4vmISObjfS0q9cNPnI/1aM0jy1jNPWTwBmS+8iVW/zIt+EyhWr/
         si8MHSypNuZrn4Mnk0zU803nGkjkQFgJ/mRktXr9rmn62zZuIaEfcKda8HRYClqhKtZG
         GgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906663; x=1689498663;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YQmPfaNN2xvCaGQ4ZNNpbl3kHI7ba/jcD2wLQvQQJU=;
        b=enEACa9hiJCdtFV5VyxlhpX50V3qokjhb/5c9EuYkjIOj/3VCRItzWl7eWp5RVEWEe
         EfaylgDRL3nTUm/5mbCiHKHSHbQk3OAFfGmYvX2HRVLje8866dL88bhp1YM+nbNUrATN
         +++RkxBq5DX23BQvQe4i+ymuwLptJHlwlb54AEfUvAXhvA2XkWO+DsEWB2aO+LjIIHzo
         +GF4k+ZHFo+4N4H7QjzWmNHcL9AuzrDw36LTI1/yGEX971E72CCvORje/zV9x1eIs/Go
         OwSJfQB0mt3NuwDoQebJG9Dj5dCnj7+KrkRLKYp1q6tSSsBVfpOP2juEZGXq2B9zvbYf
         Hhrg==
X-Gm-Message-State: AC+VfDxbGyjZJObWXx3o9btCYGgZ1HrPoutzBmSPkL2RZYPxjhA6nDqh
        IVCh4sZNsjcH9F4BldiWrRrZk2k4OHCGBAFWvmU=
X-Google-Smtp-Source: ACHHUZ4stswAvYZFHWnMolGkL3HJU8mPSzvBea47zBBnhMJNrZ4kOYrPfCgqXn7Rlgkzspw1LPyfKeFqlJMpO7CakPs=
X-Received: by 2002:a05:6870:1729:b0:1a9:ba28:99b3 with SMTP id
 h41-20020a056870172900b001a9ba2899b3mr1495645oae.17.1686906662720; Fri, 16
 Jun 2023 02:11:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6870:3925:b0:19b:2ddb:5580 with HTTP; Fri, 16 Jun 2023
 02:11:02 -0700 (PDT)
From:   "M. Cheickna Toure" <barrtraore11@gmail.com>
Date:   Fri, 16 Jun 2023 09:11:02 +0000
Message-ID: <CAJabzdONa-ssbLyxwA+fybfP=VGJRDtJV+1SddHNq-e-AENQCw@mail.gmail.com>
Subject: Hello, Good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,
Good morning and how are you?
I have an important and favourable information/ proposal which might
interest you,
I will detail you as soon as I hear from you, it's important
Sincerely,
M.Cheickna
tourecheickna@consultant.com
