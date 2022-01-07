Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774EC4874F0
	for <lists+linux-can@lfdr.de>; Fri,  7 Jan 2022 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiAGJuS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 7 Jan 2022 04:50:18 -0500
Received: from projects.drlauer-research.com ([88.99.0.140]:58702 "EHLO
        projects.drlauer-research.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237117AbiAGJuR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jan 2022 04:50:17 -0500
Received: from smtpclient.apple (b2b-109-90-164-198.unitymedia.biz [109.90.164.198])
        by projects.drlauer-research.com (Postfix) with ESMTPSA id 01DA948012B
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 10:50:13 +0100 (CET)
From:   "Dr. Michael Lauer" <mickey@vanille.de>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Filter on controller level
Message-Id: <59415BCF-B758-410C-8007-3E6CA446ACA4@vanille.de>
Date:   Fri, 7 Jan 2022 10:50:13 +0100
To:     linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        projects.drlauer-research.com
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Forgive me, if that’s a topic that already came up…

…reading the recent patch sets where hardware CAN capabilities are exposed to userland,
I wonder why we still don’t have standardized ioctls (or whatever other means) to
control the hardware arbitration masks that seem to be present in almost all CAN controllers.

In particular, I’ve stumbled over the https://github.com/craigpeacock/mcp251x, which is a driver
that exposes the hardware filtering at module load time. Wouldn’t it be helpful to
have a standardized way to control this? Also the isotp could make use of this.

Cheers,

:M:
