Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BE328F28F
	for <lists+linux-can@lfdr.de>; Thu, 15 Oct 2020 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgJOMow (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Oct 2020 08:44:52 -0400
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:33002
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgJOMow (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Oct 2020 08:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
         cc:to:from:from;
        bh=az5rzWJZl6iWf+9pQDbYodhW3y9z+VmN5cOMV8Vey4w=;
        b=HDXQ/BAQg6QeQ0AsptC0P8AKCpGpGIspdMwFqHAj91Uhc925cZweHfDjOUtwTg6Rn/jHwBELrIE2z
         DP2xx7tgiWCpOSw/tZe5PL04kdbo0jk/1BKViKT3pZMXR+TKlrXUjA/3HuHJfOZfqEnLXIVnAOb8Jx
         1ii3nRLW9Bn21KGaMic/gBN78L3LVh4WjcBQd6iI/sYgmL+1IOAIyS7qxBrO0rXljOmiWu7q/To8Cg
         GJaWO7ivkw4nbWBEMBZvxLB18dCi/kD+hal89F/U0q9qHGSWnhRSWj5vtI2328Ts8mUF9JpzoSiMo3
         l7x+QmU1oiZrNWKfKNtLUGm1iESJgJw==
X-HalOne-Cookie: 6e245a7bc6cc857c8a1b60509f1f95df81e6e71a
X-HalOne-ID: 3196f722-0ee4-11eb-a2b3-d0431ea8bb10
Received: from localhost.localdomain (unknown [5.103.118.41])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 3196f722-0ee4-11eb-a2b3-d0431ea8bb10;
        Thu, 15 Oct 2020 12:44:49 +0000 (UTC)
From:   =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
Subject: [PATCH 0/2] can: mcp251xfd: Enable support for PLL
Date:   Thu, 15 Oct 2020 13:43:59 +0100
Message-Id: <20201015124401.2766-1-mas@csselectronics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch set enables support for the internal PLL in MCP251xFD.
Tested on a RPi 4 and a MCP2518FD with an external 4 MHz oscillator.

The first part has been tested with the PLL sanity check disabled.

This is my first attempt at contributing to Linux, so let me know of any errors in format and/or style.

Magnus Aagaard Sørensen (2):
  Preparation for support of internal PLL in mcp251xfd. Moves all calls
    which would alter the clock setup, apart from probe, into PM calls.
  Enable support for internal PLL in mcp251xfd. The PLL is enabled if
    the configured clock is less than or equal to 10 times the max clock
    frequency.

 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 174 +++++++++++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   3 +
 2 files changed, 126 insertions(+), 51 deletions(-)

-- 
2.20.1

